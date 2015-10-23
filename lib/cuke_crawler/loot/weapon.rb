module CukeCrawler
  class Loot
    class Weapon < Loot
      def description
        "a deadly #{name.bold_words}"
      end

      def name
        "weapon"
      end
    end
  end
end
