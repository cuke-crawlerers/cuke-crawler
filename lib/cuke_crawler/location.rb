module CukeCrawler
  class Location
    DIRECTIONS = :north, :south, :west, :east

    DIRECTIONS.each { |direction| attr_accessor(direction) }

    attr_accessor :monster

    def initialize(seed, dungeon)
      @random = Random.new(seed)
      @spiders = @random.rand(1e3)
      @dungeon = dungeon

      if @random.rand(2) == 1
        @monster = Monster.new(seed)
      end
    end

    def connections
      [north, south, west, east].compact
    end

    def look
      result = []
      result << "You are in #{description}."
      result << exits
      result << "There is #{@monster.description} here." if @monster.present?
      result << "You catch a breath of fresh, spider-less air from the dungeon exit." if self == @dungeon.goal
      result.join("\n")
    end

    def description
      "a room filled with #{@spiders.to_i} spiders"
    end

    def exits
      exits = DIRECTIONS.select { |direction| exit?(direction) }

      if exits.size > 1
        "There are exits to the #{exits.join(" and ")}."
      elsif exits.any?
        "There is an exit to the #{exits.first}."
      else
        "There are no exits."
      end
    end

    def exit?(direction)
      send(direction).present?
    end
  end
end
