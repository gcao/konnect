class Konnect::Solution
  attr :paths
  
  def initialize game, paths
    @game = game
    @paths = paths
  end

  # return a score of 0 - 100
  # The score equals (points in all paths - min points of paths)*100 / (all points - min points of paths)
  # If there are at least 2 solutions, return the low score
  def complexity
    result = @paths.reduce(0){|sum, path| sum + path.size}
    max = @game.board_size * @game.board_size
    min = @game.pairs.reduce(0){|sum, pair| sum + pair.min_path_length}
    (result - min) * 100 / (max - min)
  end
end