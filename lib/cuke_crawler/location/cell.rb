module CukeCrawler
  class Location::Cell < Location
    def name
      "a dank cell"
    end

    def description
      "You are in a small, " + "dank cell".bold_words + ". Chains hang uselessly from the walls. There are heavy bars on the door, but you can see that the lock has been shattered... from the inside."
    end
  end
end
