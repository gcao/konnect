module Konnect
  class Point
    attr :x, :y
    attr_accessor :label, :first, :last

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
    
    def neighbor_of? x, y
      (@x - x).abs + (@y - y).abs == 1
    end
    
    def neighbor_of_point? point
      neighbor_of? point.x, point.y
    end
  end
end