module CukeCrawler
  class Location::Tunnel < Location
    def name
      "a tunnel"
    end

    def description
      "You are in a low " + "tunnel".bold_words + ". Moss grows in the cracks between the uneven stones, and the whole place smells vaguely unpleasant."
    end
  end
end
