class Konnect::Pair
  attr :label
  attr_accessor :path, :x1, :y1, :x2, :y2

  def initialize label, x1, y1, x2, y2
    @label = label
    @x1, @y1 = x1, y1
    @x2, @y2 = x2, y2
  end

  def reset
    self.path = nil
  end

  def use_point? x, y
    (x1 == x and y1 == y) or (x2 == x and y2 == y)
  end

  def min_path_length
    (x2 - x1).abs + (y2 - y1).abs + 1
  end

  def path_complexity
    path.size.to_f / min_path_length
  end
end