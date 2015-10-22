module CukeCrawler
  class Adventurer < Flavourful
    attr_reader :location

    def initialize(dungeon)
      @dungeon = dungeon
      @location = dungeon.entrance

      flavour_text "You enter the eerie #{dungeon.name} dungeon. It's scary and you wonder if you can make it out alive and not on fire."
    end

    def go(direction)
      raise RanIntoAWallError unless @location.exit?(direction)
      @location = @location.location_to(direction)
    end

    def alive?
      true
    end
  end
end
