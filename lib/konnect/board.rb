module Konnect
  class Board < Array
    EAST  = [1, 0]
    WEST  = [-1, 0]
    NORTH = [0, 1]
    SOUTH = [0, -1]
    
    def initialize size
      size.times do |i|
        self[i] = []
        size.times do |j|
          self[i][j] = Point.new(i, j)
        end
      end
    end

    def fill_in_pairs pairs
      reset
      
      @pairs = pairs
      
      pairs.each do |pair|
        self[pair.x1][pair.y1].label = pair.label
        self[pair.x2][pair.y2].label = pair.label
      end
    end

    def find_paths
      0.upto size do |i|
        
      end
    end

    def reset
      size.times do |i|
        size.times do |j|
          self[i][j].reset
        end
      end
    end
    
    def directions point1, point2
      result = []
      
      if point1.x > point2.x
        result << WEST
        
        if point1.y > point2.y
          result << SOUTH << EAST << NORTH
        elsif point.y < point2.y
          result << NORTH << EAST << SOUTH
        else
          result << NORTH << SOUTH << EAST
        end
      elsif point1.x < point2.x
        result << EAST
        
        if point1.y > point2.y
          result << SOUTH << WEST << NORTH
        elsif point.y < point2.y
          result << NORTH << WEST << SOUTH
        else
          result << NORTH << SOUTH << WEST
        end
      else
        if point1.y > point2.y
          result << SOUTH << EAST << WEST << NORTH
        elsif point.y < point2.y
          result << NORTH << EAST << WEST << SOUTH
        else
          # Should not happen
        end
      end
      
      result
    end
  end
end