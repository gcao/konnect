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
      # TODO reject pair of points which are neighbors
      reset
      
      @pairs = pairs
      
      pairs.each do |pair|
        from = self[pair.x1][pair.y1]
        from.label = pair.label
        from.first = true
        
        to = self[pair.x2][pair.y2]
        to.label = pair.label
        to.last = true
      end
    end

    def find_paths
      processed = []
      
      pair_index = 0
      from = self[@pairs[pair_index].x1][@pairs[pair_index].y1]
      to = self[@pairs[pair_index].x2][@pairs[pair_index].y2]
      processed << from
      
      while true
        if from.neighbor_of_point? to
          processed << to
          
          if pair_index < @pairs.size - 1
            pair_index += 1
            
            from = self[@pairs[pair_index].x1][@pairs[pair_index].y1]
            to = self[@pairs[pair_index].x2][@pairs[pair_index].y2]
            processed << from
          else
            # Finished processing all pairs
            break
          end
        else
          path = find_path from, to
          if path
          else # back track !!!
          end
        end
      end
      
      to_paths processed
    end
    
    def find_path from, to
      return [from, to] if from.neighbor_of_point? to
      
      directions(from, to).each do |direction|
        new_from = find_point from, *direction
        next if new_from.nil?
        
        path = find_path new_from, to
        next if path.nil?
        
        return [from, *path]
      end
    end

    def reset
      size.times do |i|
        size.times do |j|
          self[i][j].reset
        end
      end
    end
    
    def valid? x, y
      x >= 0 and x < size and y >= 0 and y < size
    end
    
    private
    
    def find_point start, xdiff, ydiff
      x = start.x + xdiff
      y = start.y + ydiff
      return nil unless valid? x, y
      
      self[x][y]
    end
    
    def to_paths processed
    end
    
    def directions point1, point2
      result = []
      
      if point1.x > point2.x
        result << WEST
        
        if point1.y > point2.y
          result << SOUTH << EAST << NORTH
        elsif point1.y < point2.y
          result << NORTH << EAST << SOUTH
        else
          result << NORTH << SOUTH << EAST
        end
      elsif point1.x < point2.x
        result << EAST
        
        if point1.y > point2.y
          result << SOUTH << WEST << NORTH
        elsif point1.y < point2.y
          result << NORTH << WEST << SOUTH
        else
          result << NORTH << SOUTH << WEST
        end
      else
        if point1.y > point2.y
          result << SOUTH << EAST << WEST << NORTH
        elsif point1.y < point2.y
          result << NORTH << EAST << WEST << SOUTH
        else
          # Should not happen
        end
      end
      
      result
    end
  end
end