module CukeCrawler
  class Pathfinder
    def initialize(start, &goal_proc)
      @start = start
      @goal = goal_proc
    end

    def path(ignore_doors = true)
      path_from(@start, ignore_doors).first
    end

    def route(ignore_doors = true)
      path_from(@start, ignore_doors).last
    end

    def path_from(start, ignore_doors = true)
      stack = [[start, [], []]]

      while !stack.empty?
        location, history, directions = stack.shift
        history << location
        return [history, directions] if @goal.call(location)
        location.connections.each_pair do |direction, connection|
          destination = connection.exits[direction]
          stack << [destination, history.dup, directions + [direction]] if !destination.deadly? && (connection.open? || ignore_doors) && !history.include?(destination)
        end
      end

      [false, false]
    end
  end
end
