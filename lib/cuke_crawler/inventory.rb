module CukeCrawler
  class Inventory < Array
    def initialize(array = [])
      super(array)
    end

    def look
      "You are carrying #{to_sentence(map(&:description))}."
    end

    alias :drop :delete

    def drop_all!
      all = self[0..-1]
      self[0..-1] = []
      all
    end

    def description
      map(&:description).to_sentence
    end

    def +(another)
      self.class.new(to_a + another.to_a)
    end

    def include?(klass)
      super || any? { |item| item.is_a?(klass) }
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
