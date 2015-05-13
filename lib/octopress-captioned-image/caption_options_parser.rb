module Octopress
  module Tags
    module CaptionedImageTag
    	class CaptionOptionsParser

    		attr_reader :position, :width, :height, :source, :float, :clear, :chrome
    		DEFAULT_POSITION = "top"

    		Source   = /((https?:\/\/|\/)\S+\.(png|gif|bmp|jpe?g)\S*)/i
        Dimensions    = /\s(auto|\d\S+)/i
        Position  = /(:?position:\s*"?(:?\w+))/i
        Float  = /(:?float:\s*"?(:?\w+))/i
        Clear  = /(:?clear:\s*"?(:?\w+))/i
        Chrome = /chrome/

    		def initialize(markup)
    			@markup = markup

    			parse_source
    			raise "No source image (png, gif, bmp, or jpeg) found in #{@markup}" unless @source

    			parse_position
    			parse_float
    			parse_clear
    			parse_dimensions
    			parse_chrome
    		end

    		private

        def parse_source
          @source = @markup.scan(Source).map(&:first).compact
        end

        def parse_position
          @position = @markup.scan(Position).flatten.last || DEFAULT_POSITION
        end

        def parse_float
          @float = @markup.scan(Float).flatten.last
        end

        def parse_clear
          @clear = @markup.scan(Clear).flatten.last
        end

        def parse_dimensions
          dimensions = @markup.scan(Dimensions).map(&:first).compact
          @width = dimensions[0]
          @height = dimensions[1]
        end

				def parse_chrome
          @chrome = @markup =~ Chrome
        end
    	end
    end
  end
end