require "octo-captioned-image/version"
require "octo-captioned-image/caption_extractor"
require "octo-captioned-image/caption_options_parser"
require "octopress-ink"

module Octopress
  module Tags
    module CaptionedImageTag
      class Tag < Liquid::Tag
        # most of this class is copied from 
        # https://github.com/octopress/video-tag/blob/master/lib/octopress-video-tag.rb

        def initialize(tag_name, markup, tokens)
          @markup = markup
          super
        end

        def render(context)
          @markup = process_liquid(context) # what is this doing? should not replace markup

          caption, remaining_markup = extract_caption(@markup)
          options = parse_options(remaining_markup)

          figure_classes = ["captioned-image#{'-chrome' if options.chrome}"]
          figure_classes << "float-#{options.float}" if options.float
          figure_classes << "clear-#{options.clear}" if options.clear
          figure_class_decl = " class=\"#{figure_classes.join(' ')}\""

          img_attributes = ""
          img_attributes += "width=\"#{options.width}\" " if options.width
          img_attributes += "height=\"#{options.height}\" " if options.height

          figcaption_class = "caption-#{options.position}"
          figcaption_class += "-chrome" if options.chrome

          fig_caption = ["  <figcaption class=\"#{figcaption_class}\">"]
          fig_caption << "    #{caption}"
          fig_caption << "  </figcaption>"

          image = options.source.map do |src| 
            # should this caption be escaped if it contains html or quotes?
            ["  <img src=\"#{src}\" alt=\"#{caption}\" #{img_attributes}/>"]
          end

          figure_content = options.position == "top" ? fig_caption + image : image + fig_caption

          figure = ["<figure#{figure_class_decl}>"]
          figure += figure_content
          figure << "</figure>"

          return figure.join("\n")
        end

        def extract_caption(markup)
          # the markup other methods use to find params has the caption removed to avoid parsing issues
          caption, remaining_markup = CaptionExtractor.extract(markup)
          return caption, remaining_markup
        end

        def parse_options(option_string)
          CaptionOptionsParser.new(option_string)
        end

        def process_liquid(context)
          Liquid::Template.parse(@markup).render!(context.environments.first)
        end
      end
    end
  end
end

Liquid::Template.register_tag('captioned_image', Octopress::Tags::CaptionedImageTag::Tag)

Octopress::Ink.add_plugin({
  name:        "Octopress Captioned Image",
  gem:         "octo-captioned-image",
  path:        File.expand_path(File.join(File.dirname(__FILE__), "../")),
  type:        "plugin",

  # Metadata which is displayed with plugin info
  version:     Octopress::Tags::CaptionedImageTag::VERSION,
  description: "Create captioned images",
  source_url:  "https://github.com/ajesler/octo-captioned-image",
  website:     "https://github.com/ajesler/octo-captioned-image"                                
})
