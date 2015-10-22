require "active_support/core_ext"

module CukeCrawler
  class Location
    attr_reader :connections

    def initialize(seed, options = {})
      @random = Random.new(seed)
      @options = options
      @connections = {}
    end

    def add_connection(connection)
      connection.exits.each_pair do |direction, destination|
        @connections[direction] = connection unless destination == self
      end
    end

    def description
      "You are in a room."
    end

    def exits
      exits = @connections.keys

      if exits.size > 1
        "There are exits to the #{exits.to_sentence}."
      elsif exits.any?
        "There is an exit to the #{exits.first}."
      else
        "There are no exits."
      end
    end

    def exit?(direction)
      @connections.include?(direction.to_sym)
    end

    def location_to(direction)
      @connections[direction.to_sym].exits[direction.to_sym]
    end
  end
end
