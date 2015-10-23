module CukeCrawler
  class Location::Spiders < Location
    def name
      "a room full of spiders"
    end

    def description
      "You are in a room full of " + "spiders".bold_words + " of all sizes and descriptions. They're supposed to be more scared of you than you are of them, but down here, nothing is certain."
    end
  end
end
