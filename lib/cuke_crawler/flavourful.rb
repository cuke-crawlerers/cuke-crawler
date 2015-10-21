require "colorize"

module CukeCrawler
  class Flavourful
    private

    def flavour_text(text)
      if !$running_from_rspec.present?
        lines = word_wrap(text)
        print "  " + separator
        lines.each do |line|
          print "    " + line
        end
        print "  " + separator
      end
    end

    def separator
      " -" * ((max_line_length / 2) + 1)
    end

    def print(line)
      puts line.cyan
    end

    def word_wrap(string)
      words = string.split("\s")
      result = []
      line = []
      words.each do |w|
        if (line.join(" ") + " #{w}").length > max_line_length
          result << line.join(" ")
          line = []
        end
        line << w
      end
      result << line.join(" ")
      result
    end

    def max_line_length
      48
    end
  end
end
