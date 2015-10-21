module CukeCrawler
  class Location
    DIRECTIONS = :north, :south, :west, :east

    DIRECTIONS.each { |direction| attr_accessor(direction) }

    def initialize(seed, options = {})
      @random = Random.new(seed)
      @options = options
    end

    def connections
      [north, south, west, east].compact
    end

    def description
      "You are in a room."
    end

    def exits
      exits = DIRECTIONS.select { |direction| exit?(direction) }

      if exits.size > 1
        "There are exits to the #{exits.to_sentence}."
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
