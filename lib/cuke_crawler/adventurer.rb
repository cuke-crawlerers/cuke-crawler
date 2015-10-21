module CukeCrawler
  class Adventurer
    class RanIntoAWallError < Error; end

    attr_reader :location

    def initialize(dungeon)
      @dungeon = dungeon
      @location = dungeon.entrance
    end

    def go_north!
      raise RanIntoAWallError if !location.north.present?
      @location = location.north
    end

    def go_south!
      raise RanIntoAWallError if !location.south.present?
      @location = location.south
    end

    def go_west!
      raise RanIntoAWallError if !location.west.present?
      @location = location.west
    end

    def go_east!
      raise RanIntoAWallError if !location.east.present?
      @location = location.east
    end
  end
end
