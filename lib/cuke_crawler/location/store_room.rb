module CukeCrawler
  class Location::StoreRoom < Location
    def name
      "a store room"
    end

    def description
      "You are in a disorganised " + "store room".bold_words + ". Boxes, barrels, and chests are stacked precariously on shelves or in piles on the stone floor, but their contents have been ransacked and spilled."
    end
  end
end
