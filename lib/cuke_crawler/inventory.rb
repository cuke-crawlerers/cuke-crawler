require "active_support/core_ext"

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
  end
end
