module CukeCrawler
  class Monster::Goblin < Monster
    def name
      "goblin"
    end

    def live_description
      "a sneaky-looking #{name.bold_words}"
    end
  end
end
