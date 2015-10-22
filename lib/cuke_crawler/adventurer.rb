module CukeCrawler
  class Adventurer
    class RanIntoAWallError < Error; end

    attr_reader :location

    def initialize(dungeon)
      @dungeon = dungeon
      @location = dungeon.entrance
    end

    ["north", "south", "west", "east"].each do |direction|
      define_method("go_#{direction}!") do
        raise RanIntoAWallError if !location.send(direction).present?

        @location = location.send(direction)
      end
    end

    def alive?
      true
    end
  end
end
