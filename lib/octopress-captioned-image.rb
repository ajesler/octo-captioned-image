require "octopress-captioned-image/version"
require "octopress-captioned-image/caption_extractor"
require "jekyll"

module Octopress
  module Tags
    module CaptionedImageTag
      class Tag < Liquid::Tag
        # most of this class is copied from 
        # https://github.com/octopress/video-tag/blob/master/lib/octopress-video-tag.rb

        @mutable_markup = nil
        @source  = nil
        @caption = ""

        Source   = /((https?:\/\/|\/)\S+\.(png|gif|bmp|jpe?g)\S*)/i
        Sizes    = /\s(auto|\d\S+)/i
        Position  = /(:?position:\s*"?(:?\w+))/i
        Float  = /(:?float:\s*"?(:?\w+))/i
        Clear  = /(:?clear:\s*"?(:?\w+))/i

        def initialize(tag_name, markup, tokens)
          @markup = markup
          super
        end

        def render(context)
          @markup = process_liquid(context)

          if caption && source

            @position = position || "top"

            fig_caption = ["  <figcaption class=\"captioned-image-caption-#{@position}\">"]
            fig_caption << "    #{@caption}"
            fig_caption << "  </figcaption>"

            image = ["  <img src=\"#{@source}\" alt=\"#{@caption}\" #{sizes}/>"]

            figure_content = @position == "top" ? fig_caption + image : image + fig_caption

            figure = ["<figure class=\"captioned-image-figure#{figure_classes}\">"]
            figure += figure_content
            figure << "</figure>"
            figure.join("\n")
          else
            raise "No image png, gif, bmp, or jpeg urls found in {% captioned_image #{@markup} %}"
          end
        end

        def caption
          @caption, @mutable_markup = CaptionExtractor.extract @markup
          @caption
        end

        def source
          @source = @mutable_markup.scan(Source).map(&:first).compact.first
        end

        def position
          p = @mutable_markup.scan(Position).flatten.last
        end

        def figure_classes
          f = @mutable_markup.scan(Float).flatten.last
          c = @mutable_markup.scan(Clear).flatten.last
          classes = ""
          classes += ".float-#{f}" if f
          classes += ".clear-#{c}" if c
        end

        def sizes
          s = @mutable_markup.scan(Sizes).map(&:first).compact
          attrs = ""
          attrs += "width=\"#{s[0]}\" " if s[0]
          attrs += "height=\"#{s[1]}\" " if s[1]
        end

        def process_liquid(context)
          Liquid::Template.parse(@markup).render!(context.environments.first)
        end
      end
    end
  end
end

Liquid::Template.register_tag('captioned_image', Octopress::Tags::CaptionedImageTag::Tag)

if defined? Octopress::Docs
  Octopress::Docs.add({
    name:        "Octopress Captioned Image Tag",
    gem:         "octopress-captioned-image",
    version:     Octopress::Tags::CaptionedImageTag::VERSION,
    description: "Creates captioned images",
    path:        File.expand_path(File.join(File.dirname(__FILE__), "../")),
    source_url:  "https://github.com/ajesler/octopress-captioned-image"
  })
end
