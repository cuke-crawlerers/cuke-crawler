module CukeCrawler
  class Inventory < Array
    def initialize(array = [])
      super(array)
    end

    def look
      "You are carrying #{map(&:description).to_sentence}."
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
        arr.map(&:bold_words).join(" and ")
      else
        arr.first(arr.length - 2).map(&:bold_words).join(", ") + ", and " . arr.last.bold_words
      end
    end
  end
end
