module CukeCrawler
  class Location
    def initialize(seed, options = {})
      @random = Random.new(seed)
      @options = options
    end
  end
end
