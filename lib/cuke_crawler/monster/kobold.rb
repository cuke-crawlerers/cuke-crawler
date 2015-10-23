module CukeCrawler
  class Monster::Kobold < Monster
    def name
      "kobold"
    end

    def live_description
      "a grumpy #{name.bold_words}"
    end
  end
end
