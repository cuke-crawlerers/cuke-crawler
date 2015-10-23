module CukeCrawler
  class Location::ThroneRoom < Location
    def name
      "the throne room"
    end

    def description
      "You are in an opulent " + "throne room".bold_words + ". Grotesque statues and nightmarish tapestries line the walls, but what really draws the eye is a huge marble throne in the centre of the room. A mouldering skeleton sits atop the throne, its hideous grin seeming to mock your quest."
    end

    def self.special?
      true
    end
  end
end
