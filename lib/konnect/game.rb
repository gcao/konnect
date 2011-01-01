module Konnect
  class Game
    attr_accessor :board_size
    attr :pairs
  
    def initialize board_size, pairs = nil
      @board_size = board_size
      @board = Board.new board_size
      @pairs = pairs
    end

    def find_paths
      @board.find_paths
      # Add paths to pairs
    end

    # Generate pairs
    def generate_pairs size
      # Get 2*size random points
      points = []
      (2 * size).times do
        while true do
          x, y = rand(board_size), rand(board_size)
          unless points.include?([x, y])
            points << [x, y]
            break
          end
        end
      end

      # Convert to pairs
      @pairs = []
      size.times do |i|
        point1 = points[2*i]
        point2 = points[2*i + 1]
        @pairs << Pair.new(LABELS[i], point1[0], point1[1], point2[0], point2[1])
      end
    end

  end
end