module CukeCrawler
  class Loot::Key < Loot
    def name
      "key"
    end

    def description
      "a small iron #{name.bold_words}"
    end
  end
end
