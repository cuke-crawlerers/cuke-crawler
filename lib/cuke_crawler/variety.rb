require "active_support/core_ext"

module CukeCrawler
  class Variety
    def self.subtypes
      key = name.demodulize.underscore
      @types ||= {}
      @types[key] ||= Dir[File.join(File.dirname(__FILE__), "#{key}/*.rb")].map do |f|
        require f
        const_get(File.basename(f, ".rb").camelize)
      end.sort_by(&:name)
    end
  end
end
