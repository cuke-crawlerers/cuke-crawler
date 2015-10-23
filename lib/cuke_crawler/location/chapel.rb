module CukeCrawler
  class Location::Chapel < Location
    def name
      "a horrible chapel"
    end

    def description
      "You are in a tiny " + "chapel".bold_words + ", a shrine to some ancient god forgotten by the outside world. A candle sputters pathetically beneath a statue of a grotesque figure with an array of wings and tentacles too nightmarish to enumerate."
    end
  end
end
