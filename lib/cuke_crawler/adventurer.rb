module CukeCrawler
  class Adventurer
    attr_reader :location

    def initialize(dungeon)
      @dungeon = dungeon
      @location = dungeon.entrance
    end
  end
end
