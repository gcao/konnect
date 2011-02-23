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

    directions(from, to).each do |direction|
      new_from = find_point from, *direction
      next if new_from.nil?
      next unless valid_for_path? new_from, from.label

      new_from.label = from.label # add to path
      path = find_path new_from, to

      if path.nil?
        new_from.label = nil # remove from path
        next
      end

      return [from, *path]
    end

    raise Konnect::NoPathError.new
  end

  def find_next_path path
    to = path.pop

    while path.size >= 2
      tried = path.pop
      tried.label = nil

      from = path.last
      choices = directions(from, to).map{|xdiff, ydiff| find_point(from, xdiff, ydiff)}.compact

      while tried != choices.last
        next_choice = choices[choices.index(tried) + 1]
        next_choice.label = to.label # add to path

        begin
          return path + find_path(next_choice, to)
        rescue Konnect::NoPathError
          next_choice.label = nil # remove from path
          tried = next_choice
        end
      end
    end

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

    [EAST, WEST, NORTH, SOUTH].detect do |xdiff, ydiff|
      neighbor = find_point point, xdiff, ydiff
      neighbor and neighbor.label == point.label and not neighbor.last?
    end
  end

  def neighbors point
    [EAST, WEST, NORTH, SOUTH].map{ |xdiff, ydiff| find_point(point, xdiff, ydiff) }.compact
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

  def to_s
    chars_at = lambda do |i, j|
      point = self[i][j]

      if not point.label.nil? and (point.first? or point.last?)
        point.label
      elsif i == 0
        if j == 0
          "\342\224\214"
        elsif j == size - 1
          "\342\224\254"
        else
          "\342\224\220"
        end
      elsif i == size - 1
        if j == 0
          "\342\224\234"
        elsif j == size - 1
          "\342\224\274"
        else
          "\342\224\244"
        end
      else
        if j == 0
          "\342\224\224"
        elsif j == size - 1
          "\342\224\264"
        else
          "\342\224\230"
        end
      end
    end

    s = "\n"
    size.times do |i|
      s << "  "
      size.times do |j|
        s << chars_at.call(i, j)
      end
      s << "\n"
    end
    s << "\n"
  end
end