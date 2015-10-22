module CukeCrawler
  module Adventure
    attr_reader :adventurer, :dungeon

    def look
      [location.description, location.exits].join(" ")
    end

    def location
      adventurer.location
    end

    def flavour(text)
      CukeCrawler::Flavourful.new.print text
    end

    def message(message)
      (@messages ||= []) << message
    end

    def flush_messages
      (@messages || []).each do |message|
        CukeCrawler::Flavourful.new.print message
      end
      @messages = []
    end
  end
end

World CukeCrawler::Adventure
