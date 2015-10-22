module CukeCrawler
  class Monster
    class IAmAlreadyDead < Error; end

    attr_accessor :loot

    def initialize(seed)
      @random = Random.new(seed)
      @alive = true
    end

    def description
      result = []
      if alive?
        result << "a gigantic spider"
        if loot.present?
          result << "holding #{loot.description}"
        end
      else
        result << "the corpse of a gigantic spider"
      end
      result.join(" ")
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
