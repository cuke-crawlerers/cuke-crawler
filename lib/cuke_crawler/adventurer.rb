module CukeCrawler
  class Adventurer < Flavourful
    class RanIntoAWallError < Error; end

    attr_reader :location

    def initialize(dungeon)
      @dungeon = dungeon
      @location = dungeon.entrance

      flavour_text "You enter the eerie #{dungeon.name} dungeon.
        It's scary and you wonder if you can make it out alive and
        not covered with spiders."
    end

    ["north", "south", "west", "east"].each do |direction|
      define_method("go_#{direction}!") do
        raise RanIntoAWallError if !location.send(direction).present?

        @location = location.send(direction)

        flavour = ["You go #{direction}. You enter #{location.description}."]

        if location == @dungeon.goal
          flavour << "You breathe in your first breath of spider-less air
            as you return to the outside world."
        end

        flavour_text flavour.join("\n")
      end
    end

    def alive?
      true
    end
  end
end
