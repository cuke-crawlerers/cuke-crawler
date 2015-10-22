module CukeCrawler
  class Monster
    class IAmAlreadyDead < Error; end

    attr_accessor :loot

    def initialize(seed)
      @random = Random.new(seed)
      @mood1 = @random.rand(MOOD_1.size)
      @mood2 = @random.rand(MOOD_2.size)
      @alive = true
      @loot = Inventory.new
    end

    def description
      result = []
      if alive?
        result << "a gigantic spider, #{mood_description}"
        if loot.any?
          result << "and holding #{loot.description}"
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

    private

    MOOD_1 = ["hissing", "meowing", "shuddering", "yelling", "contemplating"]
    MOOD_2 = ["rapidly", "profusely", "repeatedly", "passionately", "quietly"]

    def mood_description
      MOOD_1[@mood1] + " " + MOOD_2[@mood2]
    end
  end
end
