require "pleasant_lawyer"
require "active_support/inflector"
require "date"

module CukeCrawler
  class Dungeon
    attr_reader :name, :options, :monsters

    def initialize(name = nil, options = {})
      @name = (name || PleasantLawyer.number_to_words(todays_dungeon).join(" ")).titleize
      @random = Random.new(PleasantLawyer.convert(@name.downcase))
      @options = options
      @locations = generate_maze

      add_monsters

      entrance.loot << Loot::Sword.new(@dungeon)
      add_traps
    end

    def entrance
      @entrance ||= @locations.detect do |location|
        Location::Entrance === location
      end
    end

    def goal
      @goal ||= @locations.detect do |location|
        Location::ThroneRoom === location
      end
    end

    def map
      Map.new(width, height, @locations, entrance: entrance, goal: goal).to_s
    end

    def self.generate(seed)
      self.new(seed)
    end

    def description
      "the eerie #{name.bold_words} dungeon.
        It's scary and you wonder if you can make it out alive
        and not covered with spiders"
    end

    private

    def new_location(types)
      Location.factory(self, random: @random, from: types).tap do |location|
        types.delete(location.class)
      end
    end

    def generate_maze
      location_types = Location.normal_location_types.dup
      locations = coordinates.map { new_location(location_types) }
      add_entrance_to(locations)
      add_goal_to(locations)
      connect(locations)
    end

    def connect(locations)
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

    def add_entrance_to(locations)
      locations[(height - 1) * width + (width / 2).floor] =
        Location.factory(self, klass: Location::Entrance)
      locations
    end

    def add_goal_to(locations)
      index = 0
      loop do
        index = @random.rand(locations.length)
        break unless Location::Entrance === locations[index]
      end
      locations[index] = Location.factory(self, klass: Location::ThroneRoom)
      locations
    end

    def add_monsters
      locations_without_monsters = @locations - [entrance]

      @monsters = (1..(@locations.size / 2)).map do
        Monster.factory(self, random: @random).tap do |monster|
          location = locations_without_monsters.sample(random: @random)
          monster.location = location
          locations_without_monsters.delete(location)
        end
      end

      @monsters.last.location = goal unless monsters.any? { |monster| monster.location == goal }
      @monsters.first.loot << Loot::GoldenCucumber.new
    end

    def add_traps
      path_to_goal = Pathfinder.new(entrance) { |location| location == goal }
      path_to_boss = Pathfinder.new(entrance) do |location|
        location.monsters.any? { |monster| monster.carrying?(Loot::GoldenCucumber) }
      end

      unnecessary_locations = @locations - path_to_goal.path - path_to_boss.path

      replace_location(
        unnecessary_locations.sample(random: @random),
        Location.factory(self, klass: Location::Trap)
      )
    end

    def replace_location(location, another)
      connections = location.connections
      @locations[@locations.index(location)] = another
      connections.each_pair do |direction, connection|
        connected = connection.exits[direction]
        opposite = Connection.opposite(direction)
        another.connections[direction] = connection
        connection.exits[opposite] = another
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
        location = @locations.sample(random: @random)
      end
      location
    end

    def todays_dungeon
      (Date.today - Date.parse("2015-10-22")).to_i
    end
  end
end
