require "active_support/core_ext"

module CukeCrawler
  class Location < Variety
    AMBIENCES = ["dark", "musty", "mouldy", "silent", "chilly", "warm"]

    attr_reader :connections

    attr_accessor :loot

    def initialize(dungeon, seed = 0)
      super
      @connections = {}
      @ambience = @random.rand(AMBIENCES.size)
      @loot = Inventory.new

      @loot << Loot.factory(self, klass: Loot::Treasure, random: @random) if chance(0.5)
    end

    def name
      "a room"
    end

    def to_s
      name
    end

    def add_connection(connection)
      connection.exits.each_pair do |direction, destination|
        @connections[direction] = connection unless destination == self
      end
    end

    def look
      result = []
      result << description
      if !deadly?
        result << exits
        result += monsters.map { |monster| "There is #{monster.description} here." }
        result << "On the ground lies #{loot.description}." if loot.present?
      end
      result.join("\n")
    end

    def monsters
      dungeon.monsters.select { |monster| monster.location == self }
    end

    def monster
      monsters.first
    end

    def description
      "a #{ambience} room"
    end

    def exits
      exits = @connections.map do |direction, connection|
        "#{direction.to_s.bold_words} #{connection.view(direction)}"
      end

      if exits.size > 1
        "There are exits #{exits.to_sentence}."
      elsif exits.any?
        "There is an exit #{exits.first}."
      else
        "There are no exits."
      end
    end

    def exit?(direction)
      @connections.include?(direction.to_sym)
    end

    def location_to(direction)
      fail "No connections in direction '#{direction}'" unless @connections[direction.to_sym].present?

      @connections[direction.to_sym].exits[direction.to_sym]
    end

    def self.deadly?
      false
    end

    def deadly?
      self.class.deadly?
    end

    def ambience
      AMBIENCES[@ambience]
    end

    def self.special?
      false
    end

    def self.factory(dungeon, klass: nil, random: nil, from: normal_location_types)
      super
    end

    def self.normal_location_types
      subtypes.reject(&:special?)
    end

    private

    def chance(chance)
      @random.rand < chance
    end
  end
end
