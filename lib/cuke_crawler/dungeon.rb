require "pleasant_lawyer"

module CukeCrawler
  class Dungeon
    def initialize(seed)
      @random = Random.new(PleasantLawyer.convert(seed.downcase))
    end

    def self.generate(seed)
      self.new(seed)
    end

    private

    def random
      @random
    end
  end
end
