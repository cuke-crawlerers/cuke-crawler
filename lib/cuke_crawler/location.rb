require "active_support/core_ext"

module CukeCrawler
  class Location
    attr_reader :connections

    attr_accessor :monster, :loot

    def initialize(seed, dungeon, options = {})
      @random = Random.new(seed)
      @options = options
      @connections = {}
      @spiders = @random.rand(1e3)
      @dungeon = dungeon
      @loot = Inventory.new

      if @random.rand(2) == 1
        @monster = Monster.new(seed)
      end
    end

    def add_connection(connection)
      connection.exits.each_pair do |direction, destination|
        @connections[direction] = connection unless destination == self
      end
    end

    def look
      result = []
      result << "You are in #{description}."
      result << exits
      result << "There is #{monster.description} here." if monster.present?
      result << "On the ground lies #{loot.description}." if loot.present?
      result << "You catch a breath of fresh air from the dungeon exit." if self == @dungeon.goal
      result.join("\n")
    end

    def description
      "a room filled with #{@spiders.to_i} tiny spiders"
    end

    def exits
      exits = @connections.keys

      if exits.size > 1
        "There are exits to the #{exits.join(" and ")}."
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

    def be_attacked!
      monster.be_attacked!
      if !monster.alive?
        @loot += monster.loot.drop_all!
      end
    end
  end
end
