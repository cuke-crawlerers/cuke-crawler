require "colorize"

module CukeCrawler
  class Flavourful

    def print(text)
      if !$running_from_rspec.present?
        lines = word_wrap(text)
        puts "  " + separator.cyan
        lines.each do |line|
          puts "    " + line.cyan
        end
        puts "  " + separator.cyan
      end
    end

    private

    def separator
      " -" * ((max_line_length / 2) + 1)
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
