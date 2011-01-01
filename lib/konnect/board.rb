module Konnect
  class Board < Array
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
  end
end