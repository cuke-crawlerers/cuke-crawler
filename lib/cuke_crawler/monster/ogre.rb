module CukeCrawler
  class Monster::Ogre < Monster
    def name
      "ogre"
    end

    def live_description
      "a stinky #{name.bold_words}"
    end
  end
end
