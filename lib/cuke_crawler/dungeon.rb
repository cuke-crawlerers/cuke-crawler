require "pleasant_lawyer"
require "active_support/inflector"

module CukeCrawler
  class Dungeon
    attr_reader :name

    def initialize(name = PleasantLawyer.number_to_words(0).join(" "))
      @name = name.titleize
      @random = Random.new(PleasantLawyer.convert(name.downcase))
      @locations = [new_location, new_location, new_location]

      # there must be at least one monster
      while @locations.all? { |location| !location.monster.present? } do
        @locations[1] = new_location
      end

      @locations[0].north = @locations[1]; @locations[1].south = @locations[0]
      @locations[1].north = @locations[2]; @locations[2].south = @locations[1]

      boss = @locations.select { |location| location.monster.present? }.first
      boss.monster.loot = GoldenCucumber.new
    end

    def entrance
      @locations.first
    end

    def goal
      @locations.last
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
  end
end
