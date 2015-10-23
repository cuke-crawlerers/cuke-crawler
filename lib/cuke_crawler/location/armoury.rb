module CukeCrawler
  class Location::Armoury < Location
    def initialize(*args)
      super(*args)
      loot << Loot::Axe.new(@dungeon)
    end

    def name
      "an armoury"
    end

    def description
      "You are in a cramped armoury. Weapons of various descriptions stand in racks or hang from hooks on the walls, and there are mismatched pieces of armour on mannequins and littering the floor. Some of the armour is much too small for you, and some is far too big for anyone you hope to meet down here."
    end
  end
end
