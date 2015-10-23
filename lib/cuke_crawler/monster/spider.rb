module CukeCrawler
  class Monster::Spider < Monster
    def name
      "spider"
    end

    def live_description
      "a giant #{name.bold_words}"
    end
  end
end
