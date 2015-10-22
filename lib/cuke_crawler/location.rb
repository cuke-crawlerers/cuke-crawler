require "active_support/core_ext"

module CukeCrawler
  class Location
    AMBIENCES = ["dark", "musty", "mouldy", "silent", "chilly", "warm"]

    attr_reader :connections

    attr_accessor :monster, :loot, :death

    def initialize(dungeon, seed = 0)
      @random = Random.new(seed)
      @connections = {}
      @spiders = @random.rand(1e3.to_i)
      @dungeon = dungeon
      @ambience = @random.rand(AMBIENCES.size)
      @loot = Inventory.new

      if @random.rand(2) == 1
        @monster = Monster.new(seed)
      end
    end

    def name
      "a room"
    end

    def to_s
      "[#{@spiders} spiders]"
    end

    def add_connection(connection)
      connection.exits.each_pair do |direction, destination|
        @connections[direction] = connection unless destination == self
      end
    end

    def look
      result = []
      result << description
      result << exits
      result << "There is #{monster.description} here." if monster.present?
      result << "On the ground lies #{loot.description}." if loot.present?
      result.join("\n")
    end

    def description
      if death?
        "a deadly pit of #{@spiders} venomous spiders"
      else
        "a #{ambience} room filled with #{@spiders} tiny spiders"
      end
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
      fail "No connections in direction '#{direction}'" unless @connections[direction.to_sym].present?

      @connections[direction.to_sym].exits[direction.to_sym]
    end

    def be_attacked!
      monster.be_attacked!
      if !monster.alive?
        @loot += monster.loot.drop_all!
      end
    end

    def death?
      death
    end

    def ambience
      AMBIENCES[@ambience]
    end

    def self.special?
      false
    end
  end
end
