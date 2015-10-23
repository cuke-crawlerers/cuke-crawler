module CukeCrawler
  class Loot
    class Axe < Weapon
      def description
        "a mighty #{name.bold_words}"
      end

      def name
        "axe"
      end
    end
  end
end
