module CukeCrawler
  class Location::Passageway < Location
    def name
      "a narrow passage"
    end

    def description
      "You are in a narrow " + "passageway".bold_words + ". Some attempt has been made at a floor and walls, and there is even a portrait of a wizened old goblin on the west wall whose eyes seem to follow you creepily."
    end
  end
end
