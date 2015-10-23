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
      connection = @location.connections[direction.to_sym]
      connection.open_with!(inventory)
      @location = @location.location_to(direction)
      @alive = false if @location.deadly?
    end

    def alive?
      @alive
    end

    def attack!(monster)
      monster.kill!
    end
  end
end
