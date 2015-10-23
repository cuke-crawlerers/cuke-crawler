module CukeCrawler
  class Monster::Golem < Monster
    def name
      "golem"
    end

    def live_description
      "a shambling #{name.bold_words}"
    end
  end
end
