module CukeCrawler
  class Map
    attr_reader :width, :height

    def initialize(width, height, locations, options = {})
      @width = width
      @height = height
      @locations = locations
      @options = options
    end

    def to_s
      [
        (0...height).map { |y| row(y) },
        ("+-" * width) + "+"
      ].flatten.join("\n")
    end

    private

    def row(y)
      [
        (0...width).map { |x| top(x, y) }.join + "+",
        (0...width).map { |x| middle(x, y) }.join + "|",
      ].join("\n")
    end

    def top(x, y)
      "+" + (at(x, y).exit?(:north) ? " " : "-")
    end

    def middle(x, y)
      (at(x, y).exit?(:west) ? " " : "|") + occupant(x, y)
    end

    def at(x, y)
      @locations[y * width + x]
    end

    def occupant(x, y)
      case at(x, y)
      when @options[:entrance] then "*"
      when @options[:goal]     then "!"
      else " "
      end
    end
  end
end
