module CukeCrawler
  class Loot
    class Sword < Weapon
      def description
        "a trusty #{name.bold_words}"
      end

      def name
        "sword"
      end
    end
  end
end
