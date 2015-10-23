module CukeCrawler
  class Connection
    attr_reader :exits

    def initialize(exits)
      @exits = exits
    end

    def view(direction)
      "to " + exits[direction].name
    end

    def open?
      true
    end

    def open_with!(inventory)
      true
    end

    def self.opposite(direction)
      case direction
      when :north then :south
      when :south then :north
      when :west then :east
      when :east then :west
      end
    end
  end
end
