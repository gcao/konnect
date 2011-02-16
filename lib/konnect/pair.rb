class Konnect::Pair
  attr :label
  attr_accessor :path, :x1, :y1, :x2, :y2

  def initialize label, x1, y1, x2, y2
    @label = label
    @x1, @y1 = x1, y1
    @x2, @y2 = x2, y2
  end

  def use_point? x, y
    (x1 == x and y1 == y) or (x2 == x and y2 == y)
  end
end