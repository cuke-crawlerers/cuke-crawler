module CukeCrawler
  class Monster
    class IAmAlreadyDead < Error; end

    def initialize(seed, options = {})
      @random = Random.new(seed)
      @alive = true
    end

    def description
      "a gigantic #{alive? ? "" : "dead"} spider"
    end

    def alive?
      @alive
    end

    def be_attacked!
      raise IAmAlreadyDead unless alive?

      @alive = false
    end
  end
end
