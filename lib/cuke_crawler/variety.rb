require "active_support/core_ext"

module CukeCrawler
  class Variety
    attr_accessor :dungeon

    def initialize(dungeon, seed = 0)
      @dungeon = dungeon
      @random = Random.new(seed)
    end

    def self.subtypes
      key = name.demodulize.underscore
      @types ||= {}
      @types[key] ||= Dir[File.join(File.dirname(__FILE__), "#{key}/*.rb")].map do |f|
        require f
        const_get(File.basename(f, ".rb").camelize)
      end.sort_by(&:name)
    end

    def self.factory(dungeon, klass: nil, random: nil, from: subtypes)
      random ||= Random.new(0)
      seed = random.rand(LARGE_NUMBER)
      klass ||= from.sample(random: random)
      klass.new(dungeon, seed)
    end
  end
end
