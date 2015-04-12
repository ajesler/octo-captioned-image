module Octopress
  module Tags
    module CaptionedImageTag
      class CaptionExtractor

      	QSINGLE = "'"
        QDOUBLE = '"'

      	def self.extract(markup)

      		# find the first quote instance 
          c, start = caption_start(markup)

          partial = markup[start+1..-1]
        	fin = -1
        	caption = nil

          partial.chars.each_with_index do |v,i|
          	if v == c && partial[i-1] != '\\'
          		fin = i
          		caption = partial[0..fin-1]
          		break
          	end
          end

          # remove the comment string from @mutable_markup
          remainder = markup[0..(start-1)]+markup[(start+fin+2)..-1]

          # swap " -> &quot; and ' -> &#39; in caption
          if c == QDOUBLE
            caption.gsub!("\\#{QDOUBLE}", "&quot;")
          else
            caption.gsub!("\\#{QSINGLE}", "&#39;")
          end

      		return caption, remainder
      	end

      	private

      	def self.caption_start(markup)
          di = markup.index(QDOUBLE)
          si = markup.index(QSINGLE)

          if di && si && di < si
            return QDOUBLE, di
          elsif di && si && si < di
            return QSINGLE, si
          elsif di && !si
            return QDOUBLE, di
          elsif si && !di
            return QSINGLE, si
          else
            raise "Could not find a quoted caption in #{@markup}"
          end
        end
      end
	  end
	end
end