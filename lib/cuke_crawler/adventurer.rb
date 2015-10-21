module CukeCrawler
  class Adventurer < Flavourful
    class RanIntoAWallError < Error; end

    attr_reader :location

    def initialize(dungeon)
      @dungeon = dungeon
      @location = dungeon.entrance

      flavour_text "You enter the eerie #{dungeon.name} dungeon. It's scary and you wonder if you can make it out alive and not on fire."
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

    def alive?
      true
    end
  end
end
