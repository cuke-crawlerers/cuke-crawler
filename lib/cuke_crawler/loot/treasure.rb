module CukeCrawler
  class Loot
    class Treasure < Loot
      def initialize(dungeon, seed)
        super
        @descriptor = descriptors.sample(random: @random)
        @container = containers.sample(random: @random)
        @contents = contents.sample(random: @random)
      end

      def name
        @contents
      end

      def description
        "a #{@descriptor} #{@container} of #{@contents}"
      end

      private

      def descriptors
        %w(small large mysterious depleted fascinating curious)
      end

      def containers
        %w(box jar tube bottle assortment pouch purse)
      end

      def contents
        [ "gemstones", "wood shavings", "teeth", "sandwiches", "goblin pubes", "buttons", "boiled sweets", "coloured sand", "marbles", "lint", "dried peas", "bath salts", "bees", "chickpeas", "carved figures", "knucklebones", "leather scraps", "rubies", "emeralds", "pretzels" ]
      end
    end
  end
end
