module CukeCrawler
  class Location
    attr_accessor :north, :south, :west, :east

    def initialize(seed, options = {})
      @random = Random.new(seed)
      @options = options
    end

    def connections
      [north, south, west, east].compact
    end
  end
end
