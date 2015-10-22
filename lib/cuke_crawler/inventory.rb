module CukeCrawler
  class Inventory < Array
    def initialize
      super([])
    end

    def look
      "In your inventory you see #{to_sentence(map(&:description))}."
    end

    private

    def to_sentence(arr)
      case arr.length
      when 0
        "nothing"
      when 1, 2
        arr.join(" and ")
      else
        arr.first(arr.length - 2).join(", ") + ", and " . arr.last
      end
    end
  end
end
