module CukeCrawler
  class Adventurer
    attr_reader :location, :inventory

    def initialize(dungeon)
      @dungeon = dungeon
      @location = dungeon.entrance
      @inventory = Inventory.new
      @alive = true
    end

    def go(direction)
      raise RanIntoAWallError unless @location.exit?(direction)
      @location = @location.location_to(direction)
    end

    def alive?
      @alive
    end

    def attack!
      location.be_attacked!
    end
  end
end
