module Konnect
  class Point
    attr :x, :y
    attr_accessor :label, :part_of_path

    def initialize x, y
      @x, @y = x, y
    end

    def part_of_path?
      @part_of_path
    end

    def reset
      @label = nil
      @part_of_path = nil
    end
  end
end