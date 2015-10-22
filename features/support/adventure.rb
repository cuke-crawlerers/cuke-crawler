module CukeCrawler
  module Adventure
    attr_reader :adventurer, :dungeon

    def look
      [location.description, location.exits].join(" ")
    end

    def location
      adventurer.location
    end
  end
end

World CukeCrawler::Adventure
