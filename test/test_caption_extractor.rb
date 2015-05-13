require 'minitest/autorun'
require "octo-captioned-image/caption_extractor"

class TestCaptionExtractor < Minitest::Test

	IMAGE_PATH = "https://images/my_image.jpg"

	def setup
		@extractor = Octopress::Tags::CaptionedImageTag::CaptionExtractor
	end

	def test_simple 
		caption = 'This is my caption'
		p = "/images/my_image.png "
		markup = "#{p}\"#{caption}\""
		c, r = @extractor.extract(markup)
		assert_equal caption, c
		assert_equal p, r
	end

	def test_simple_options 
		caption = 'Adventure awaits!'
		p = ["#{IMAGE_PATH} ", " float:\"left\" clear:\"right\""]
		markup = "#{p[0]}\"#{caption}\"#{p[1]}"
		c, r = @extractor.extract(markup)
		assert_equal caption, c
		assert_equal p.join, r
	end

	def test_apostrophe_in_caption
		caption = 'The O\\\'*s have been breaking systems for a while'
		p = ["#{IMAGE_PATH} ", " float:\"left\" clear:\"right\""]
		markup = "#{p[0]}\"#{caption}\"#{p[1]}"
		c, r = @extractor.extract(markup)
		assert_equal caption, c
		assert_equal p.join, r
	end

	def test_single_quote_in_caption
		caption = "\'Pratchett once wrote \\\'Stupid men are often capable of things the clever would not dare to contemplate...\\\'\'"
		p = ["#{IMAGE_PATH} ", " 300px 500px float:\"left\" clear:\"right\""]
		expected = "Pratchett once wrote &#39;Stupid men are often capable of things the clever would not dare to contemplate...&#39;"
		markup = [p[0], caption, p[1]].join
		c, r = @extractor.extract(markup)
		assert_equal expected, c 
		assert_equal p.join, r
	end

	def test_double_quote_in_caption
		caption = "\"Pratchett once wrote \\\"Gravity is a habit that is hard to shake off.\\\"\""
		p = ["#{IMAGE_PATH} ", " 300px 500px float:\"left\" clear:\"right\""]
		expected = "Pratchett once wrote &quot;Gravity is a habit that is hard to shake off.&quot;"
		markup = [p[0], caption, p[1]].join
		c, r = @extractor.extract(markup)
		assert_equal expected, c 
		assert_equal p.join, r
	end

	def test_html_in_caption
		caption = "\"Wiring diagram for the lamp - created with <a href=\\\"http://fritzing.org\\\">fritzing</a>\""
		p = ["#{IMAGE_PATH} ", " 300px 500px float:\"left\" clear:\"right\""]
		expected = "Wiring diagram for the lamp - created with <a href=&quot;http://fritzing.org&quot;>fritzing</a>"
		markup = [p[0], caption, p[1]].join
		c, r = @extractor.extract(markup)
		assert_equal expected, c 
		assert_equal p.join, r
	end
end