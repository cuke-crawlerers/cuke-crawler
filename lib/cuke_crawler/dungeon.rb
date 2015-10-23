require "pleasant_lawyer"
require "active_support/inflector"

module CukeCrawler
  class Dungeon
    attr_reader :name, :options, :monsters

    def initialize(name = nil, options = {})
      @name = (name || PleasantLawyer.number_to_words(0).join(" ")).titleize
      @random = Random.new(PleasantLawyer.convert(@name.downcase))
      @options = options
      @locations = generate_maze

      entrance.loot << Loot::Sword.new(@dungeon)

      add_monsters
      add_traps
      hide_key
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
      "the eerie #{name} dungeon.
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
          mapped << [x, y - 1]
        elsif direction == :south
          destination = locations[(y + 1) * width + x]
          mapped << [x, y + 1]
        elsif direction == :west
          destination = locations[y * width + x - 1]
          mapped << [x - 1, y]
        elsif direction == :east
          destination = locations[y * width + x + 1]
          mapped << [x + 1, y]
        end
        klass = (Location::ThroneRoom === destination || Location::ThroneRoom === origin) ? Door : Connection
        connection = klass.new(direction => destination, Connection.opposite(direction) => origin)
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

    def hide_key
      paths = @locations.reject(&:deadly?).map do |location|
        Pathfinder.new(location) { |room| Location::Entrance === room }
          .path(false)
      end
      paths = (paths - [false]).sort_by(&:length).reverse
      location = paths.first.first
      (location.monsters.first || location).loot << Loot::Key.new(self)
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
  end
end
