require 'minitest/autorun'
require "octopress-captioned-image/caption_options_parser"

class TestCaptionOptionsParser < Minitest::Test

	IMAGE_PATH = "https://images/my_image.png"

	def parse_options(markup)
		Octopress::Tags::CaptionedImageTag::CaptionOptionsParser.new(markup)
	end

	def test_errors_if_no_source
		begin 
			parse_options("")
			fail
		rescue Exception => e
			pass
		end
	end

	def test_handles_default_position 
		markup = "#{IMAGE_PATH}"

		options = parse_options(markup)

		expected_default = Octopress::Tags::CaptionedImageTag::CaptionOptionsParser::DEFAULT_POSITION
		assert_equal expected_default, options.position
	end

	def test_no_width_and_height
		markup = " position:\"bottom\" float:\"left\" clear:\"right\" chrome"

		options = parse_options(markup)

		assert !options.width
		assert !options.height
		assert_equal "bottom", options.position
		assert_equal "left", options.float
		assert_equal "right", options.clear
		assert options.chrome
	end

	def test_all_options_given
		markup = " 1000px 500px position:\"bottom\" float:\"left\" clear:\"right\" chrome"

		options = parse_options(markup)

		assert_equal "1000px", options.width
		assert_equal "500px", options.height
		assert_equal "bottom", options.position
		assert_equal "left", options.float
		assert_equal "right", options.clear
		assert options.chrome
	end

end