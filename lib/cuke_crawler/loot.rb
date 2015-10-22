module CukeCrawler
  class Loot < Variety
    def description
      "a mysterious object"
    end

    def name
      "item"
    end

    def self.weapon_types
      subtypes_of(Weapon)
    end

    def self.subtypes_of(type)
      subtypes.select { |klass| (klass.ancestors - [klass]).include?(type) }
    end
  end
end
