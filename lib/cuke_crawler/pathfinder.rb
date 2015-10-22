module CukeCrawler
  class Pathfinder
    def initialize(start, &goal_proc)
      @start = start
      @goal = goal_proc
    end

    def path
      path_from(@start).first
    end

    def route
      path_from(@start).last
    end

    private

    def path_from(start)
      stack = [[start, [], []]]

      while !stack.empty?
        location, history, directions = stack.shift
        history << location
        return [history, directions] if @goal.call(location)
        location.connections.each_pair do |direction, connection|
          destination = connection.exits[direction]
          stack << [destination, history.dup, directions + [direction]] unless history.include?(destination)
        end
      end

      [false, false]
    end
  end
end
