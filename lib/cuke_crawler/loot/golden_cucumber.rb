module CukeCrawler
  class Loot
    class GoldenCucumber < Treasure
      def initialize
      end

      def description
        "a magnificent golden #{name.bold_words}"
      end

      def name
        "cucumber"
      end
    end
  end
end
