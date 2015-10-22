module CukeCrawler
  class Location::Entrance < Location
    def name
      "the dungeon entrance"
    end

    def description
      "You stand at the entrance to the #{@dungeon.name} dungeon. A sense of trepidation fills you as you contemplate the task ahead of you, but the consequences of failure weigh heavy on your shoulders."
    end

    def self.special?
      true
    end
  end
end
