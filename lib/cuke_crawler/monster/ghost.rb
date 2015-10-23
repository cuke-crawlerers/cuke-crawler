module CukeCrawler
  class Monster::Ghost < Monster
    def name
      "ghost"
    end

    def live_description
      "a spooky #{name.bold_words}"
    end
  end
end
