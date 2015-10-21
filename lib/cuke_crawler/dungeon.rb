require "pleasant_lawyer"
require "active_support/inflector"

module CukeCrawler
  class Dungeon
    attr_reader :name

    def initialize(name = PleasantLawyer.number_to_words(0).join(" "))
      @name = name.titleize
      @random = Random.new(PleasantLawyer.convert(name.downcase))
      @locations = [location, location]
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

    private

    def location(options = {})
      Location.new(@random.rand(LARGE_NUMBER), options)
    end
  end
end
