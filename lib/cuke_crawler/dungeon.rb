require "pleasant_lawyer"
require "active_support/inflector"

module CukeCrawler
  class Dungeon
    attr_reader :name, :options

    def initialize(name = nil, options = {})
      @name = (name || PleasantLawyer.number_to_words(0).join(" ")).titleize
      @random = Random.new(PleasantLawyer.convert(@name.downcase))
      @options = options
      @locations = generate_maze

      @boss = @locations.select { |location| location.monster.present? }.first
      @boss.monster.loot << Loot::GoldenCucumber.new
      entrance.loot << Loot::Sword.new
      add_death
    end

    def entrance
      @entrance ||= @locations[(height - 1) * width + (width / 2).floor]
    end

    def goal
      @goal ||= random_location_that_isnt(entrance)
    end

    def map
      Map.new(width, height, @locations, entrance: entrance, goal: goal).to_s
    end

    def self.generate(seed)
      self.new(seed)
    end

    def description
      "the eerie #{name} dungeon.
        It's scary and you wonder if you can make it out alive
        and not covered with spiders"
    end

    private

    def new_location
      Location.new(@random.rand(LARGE_NUMBER), self)
    end

    def generate_maze
      locations = coordinates.map { new_location }
      add_exits_to(locations)
    end

    def add_exits_to(locations)
      mapped = Set.new([[0, 0]])

      while mapped.size < locations.size
        candidates = mapped.each.with_object([]) do |(x, y), walls|
          walls << [x, y, :north] if y > 1 && !mapped.include?([x, y - 1])
          walls << [x, y, :south] if y < height - 1 && !mapped.include?([x, y + 1])
          walls << [x, y, :west] if x > 1 && !mapped.include?([x - 1, y])
          walls << [x, y, :east] if x < width - 1 && !mapped.include?([x + 1, y])
        end

        x, y, direction = candidates[@random.rand(candidates.length)]
        origin = locations[y * width + x]
        connection = false
        if direction == :north
          destination = locations[(y - 1) * width + x]
          connection = Connection.new(north: destination, south: origin)
          mapped << [x, y - 1]
        elsif direction == :south
          destination = locations[(y + 1) * width + x]
          connection = Connection.new(south: destination, north: origin)
          mapped << [x, y + 1]
        elsif direction == :west
          destination = locations[y * width + x - 1]
          connection = Connection.new(west: destination, east: origin)
          mapped << [x - 1, y]
        elsif direction == :east
          destination = locations[y * width + x + 1]
          connection = Connection.new(east: destination, west: origin)
          mapped << [x + 1, y]
        end
        origin.add_connection(connection)
        destination.add_connection(connection)
      end

      locations
    end

    def add_death
      unnecessary_locations = @locations - critical_success_path(goal) - critical_success_path(@boss)
      unnecessary_locations.each do |location|
        location.death = true
      end
    end

    def width
      options[:width] || 3
    end

    def height
      options[:height] || 3
    end

    def coordinates
      (0...width).to_a.product((0...height).to_a)
    end

    def random_location_that_isnt(start)
      location = start
      while location == start
        location = @locations[@random.rand(@locations.length)]
      end
      location
    end

    def critical_success_path(path_goal)
      fail "no goal" unless path_goal.present?

      100.times do
        path = [entrance]
        100.times do
          directions = ["north", "south", "west", "east"].select { |d| path.last.exit?(d) }
          index = @random.rand(directions.length)
          direction = directions[index]
          break if path.include?(path.last.location_to(direction))
          path << path.last.location_to(direction)
          return path if path.last == path_goal
        end
      end
      fail "I couldn't generate any critical success paths to #{path_goal}"
    end
  end
end
