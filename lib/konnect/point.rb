class Konnect::Point
  attr_reader :x, :y
  attr_writer :first, :last
  attr_accessor :label

  def initialize x, y
    @x, @y = x, y
  end

  def first?; @first; end
  def last?; @last; end

  def reset
    @label = nil
    @first = nil
    @last = nil
  end

  def distance_to x, y
    (@x - x).abs + (@y - y).abs
  end

  def neighbor_of? x, y
    distance_to(x, y) == 1
  end

  def neighbor_of_point? point
    neighbor_of? point.x, point.y
  end
end