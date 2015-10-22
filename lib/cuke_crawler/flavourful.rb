require "colorize"

module CukeCrawler
  class Flavourful

    def print(text)
      if !$running_from_rspec.present?
        word_wrap(text).each { |line| puts line.cyan }
      end
    end

    private

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
      54
    end
  end
end
