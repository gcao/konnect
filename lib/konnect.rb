module Konnect
  LABELS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  
  class Point
    attr_accessor :label
    attr :x, :y
    
    def initialize x, y
      @x, @y = x, y
    end
  end

  class Path < Array
    attr :label

    def initialize label
      @label = label
    end
  end

  class Board < Array
    def initialize size
      0.upto size do |i|
        self[i] = []
        0.upto size do |j|
          self[i][j] = Point.new(i, j)
        end
      end
    end
    
    def fill_in_pairs pairs
      pairs.each_index do |i|
        coord = pairs[i]
        point = self[coord[0]][coord[1]]
        point.label = LABELS[i/2, 1]
      end
    end
    
    def find_paths
      0.upto size do |i|

      end
    end
    
    def reset
    end
  end
  
  class Game
    attr_accessor :board_size, :pair_size
    attr :pairs
  
    def initialize board_size, pair_size
      @board_size = board_size
      @board = Board.new board_size
      
      @pair_size = pair_size
      @pairs = generate(board_size, pair_size)
    end

    def find_paths
      @path ||= @board.find_paths
    end
  
    private

    # Generate coordinates
    def generate board_size, size
      pairs = []
      (size * 2).times do
        while true do
          point = [rand(board_size), rand(board_size)]
          unless pairs.include?(point)
            pairs << point
            break
          end
        end
      end
      pairs
    end
  
  end
end
