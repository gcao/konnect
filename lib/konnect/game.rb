class Konnect::Game
  attr :pairs

  def initialize board_size, pairs
    @board = Konnect::Board.new board_size
    @pairs = pairs
    @board.fill_in_pairs pairs
  end

  def find_paths
    @paths ||= @board.find_paths
  end

  def find_alternative_paths
    @alternative_paths ||= @board.find_alternative_paths
  end

  def self.generate board_size, pairs_size
    # Get 2 * pairs_size random points
    points = []
    (2 * pairs_size).times do |i|
      while true do
        x, y = rand(board_size), rand(board_size)

        next if points.include?([x, y])

        if i % 2 == 1
          # Skip point whose distance from the first in the pair is less than 3
          next if Konnect::Point.new(x, y).distance_to(*points[i - 1]) < 3
        end
        
        points << [x, y]
        break
      end
    end

    # Convert to pairs
    pairs = []
    pairs_size.times do |i|
      point1 = points[2*i]
      point2 = points[2*i + 1]
      pairs << Konnect::Pair.new(Konnect::LABELS[i], point1[0], point1[1], point2[0], point2[1])
    end

    new board_size, pairs
  end

end