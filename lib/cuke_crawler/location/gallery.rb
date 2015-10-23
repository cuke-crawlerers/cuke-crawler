module CukeCrawler
  class Location::Gallery < Location
    def name
      "a grotesque gallery"
    end

    def description
      "You are in a grotesque " + "gallery".bold_words + ". The walls are covered floor to ceiling in ancient, cracked paintings. It's hard to tell whether the subjects were genuinely ugly, or if the artist just lacked talent. Possibly both."
    end
  end
end
