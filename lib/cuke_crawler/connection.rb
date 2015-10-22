module CukeCrawler
  class Connection
    attr_reader :exits

    def initialize(exits)
      @exits = exits
    end
  end
end
