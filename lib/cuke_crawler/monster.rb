module CukeCrawler
  class Monster < Variety
    class IAmAlreadyDead < Error; end

    attr_accessor :loot, :location

    def initialize(dungeon, seed = 0)
      super
      @alive = true
      @loot = Inventory.new
      @loot << Loot.factory(@dungeon, klass: Loot::Treasure, random: @random)
    end

    def description
      if alive?
        live_description
      else
        "the corpse of #{live_description}"
      end
    end

    def alive?
      @alive
    end

    def kill!
      raise IAmAlreadyDead unless alive?
      location.loot += loot.drop_all!
      @alive = false
      true
    end

    def carrying?(klass)
      loot.any? { |item| klass === item }
    end
  end
end
