module CukeCrawler
  module Adventure
    attr_reader :adventurer, :dungeon

    def describe_location
      "You are in a location. There are no exits."
    end
  end
end

World CukeCrawler::Adventure
