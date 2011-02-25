require 'pry'

class Konnect::Board < Array
  EAST  = [1, 0]
  WEST  = [-1, 0]
  NORTH = [0, 1]
  SOUTH = [0, -1]

  def initialize size
    size.times do |i|
      self[i] = []
      size.times do |j|
        self[i][j] = Konnect::Point.new(i, j)
      end
    end
  end

  def fill_in_pairs pairs
    @pairs = pairs

    reset

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
    pair_index = 0

    while pair_index < @pairs.size
      pair = @pairs[pair_index]
      path = pair.path

      begin
        if path
          path = find_next_path path
        else
          from = self[pair.x1][pair.y1]
          to = self[pair.x2][pair.y2]

          path = find_path from, to
        end

        pair.path = path
        pair_index += 1
      rescue Konnect::NoPathError
        if pair_index == 0
          raise
        else
          puts "---------------"
          puts self.to_s
          pair.path = nil
          pair_index -= 1
        end
      end
    end

    @pairs.map{|pair| pair.path}
  end

  # Calculate paths in the reverse order, then return paths in the normal order
  def find_alternative_paths
    reset
    
    @pairs.reverse!
    find_paths
    @pairs.reverse!

    @pairs.map{|pair| pair.path}
  end

  def find_path from, to
    return [from, to] if from.neighbor_of_point? to
#puts to_s
#pry
    Board.directions(from, to).each do |direction|
      new_from = find_point from, *direction
      next if new_from.nil?
      next unless valid_for_path? new_from, from.label

      begin
        new_from.label = from.label # add to path
        path = find_path new_from, to
        return [from, *path]
      rescue Konnect::NoPathError
        new_from.label = nil
      end
    end

    raise Konnect::NoPathError.new
  end

  def find_next_path path
#puts to_s
#pry
    to = path.pop

    while path.size >= 2
      tried = path.pop
      tried.label = nil

      from = path.last
      choices = Board.directions(from, to).map{|xdiff, ydiff| find_point(from, xdiff, ydiff)}.compact

      while tried != choices.last
        next_choice = choices[choices.index(tried) + 1]
        unless valid_for_path? next_choice, to.label
          tried = next_choice
          next
        end

        next_choice.label = to.label # add to path

        begin
          return path + find_path(next_choice, to)
        rescue Konnect::NoPathError
          next_choice.label = nil # remove from path
          tried = next_choice
        end
      end
    end

    puts self.to_s
    raise Konnect::NoPathError.new
  end

  def reset
    @pairs.each {|pair| pair.reset} if @pairs
    
    size.times do |i|
      size.times do |j|
        self[i][j].reset
      end
    end
  end

  def valid? x, y
    x >= 0 and x < size and y >= 0 and y < size
  end

  def find_point start, xdiff, ydiff
    x = start.x + xdiff
    y = start.y + ydiff
    self[x][y] if valid? x, y
  end

  def valid_for_path? point, label
    return false if point.label

    # Skip point which can be reached from 2 points in path.
    i = 0
    [EAST, WEST, NORTH, SOUTH].each do |xdiff, ydiff|
      neighbor = find_point point, xdiff, ydiff
      i += 1 if neighbor and neighbor.label == label and not neighbor.last?
    end
    i == 1
  end

  #def neighbors point
  #  [EAST, WEST, NORTH, SOUTH].map{ |xdiff, ydiff| find_point(point, xdiff, ydiff) }.compact
  #end

  def self.directions point1, point2
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

  def to_s
    colors = %W(\033[31m \033[32m \033[33m \033[34m \033[35m \033[36m \033[37m)
    black = "\033[0m"
    chars_at = lambda do |i, j|
      point = self[i][j]

      if not point.label.nil? #and (point.first? or point.last?)
        s = colors[point.label.bytes.first - "A".bytes.first]
        s += "\033[1m"  # bold
        s += "\033[4m" if point.first? # underline
        s += "\033[7m" if point.last? # invert
        s += point.label
        s + black
      elsif i == 0
        if j == 0
          "\342\224\214"
        elsif j == size - 1
          "\342\224\220"
        else
          "\342\224\254"
        end
      elsif i == size - 1
        if j == 0
          "\342\224\224"
        elsif j == size - 1
          "\342\224\230"
        else
          "\342\224\264"
        end
      else
        if j == 0
          "\342\224\234"
        elsif j == size - 1
          "\342\224\244"
        else
          "\342\224\274"
        end
      end
    end

    s = "\n"
    size.times do |i|
      s << "  "
      size.times do |j|
        s << chars_at.call(i, j) << " "
      end
      s << "\n"
    end
    s << "\n"
  end
end