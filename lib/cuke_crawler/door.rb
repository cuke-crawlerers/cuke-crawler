module CukeCrawler
  class Door < Connection
    def initialize(exits)
      super
      @open = false
    end

    def view(direction)
      if open?
        super
      else
        "through a heavy oaken door"
      end
    end

    def open?
      @open
    end

    def open_with!(inventory)
      raise LockedDoorError, "The door is locked" unless inventory.include?(Loot::Key)
      @open = true
    end
  end
end
