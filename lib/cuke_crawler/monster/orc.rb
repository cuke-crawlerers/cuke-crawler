module CukeCrawler
  class Monster::Orc < Monster
    def name
      "orc"
    end

    def live_description
      "a menacing #{name.bold_words}"
    end
  end
end
