require File.expand_path(File.dirname(__FILE__) + "/lib/konnect")
#require File.expand_path(File.dirname(__FILE__) + "/lib/konnect/shoes")

game = Konnect::Game.generate 6, 5

width = height = game.board.size * 60 + 2 * 10

Shoes.app width: width, height: height do
  # Draw board
  clear do
    background black
    stack margin: 10 do
      fill rgb(0, 90, 0)
      width = height = game.board.size * 60
      rect left: 0, top: 0, width: width, height: height

      0.upto(game.board.size) do |i|
        x, y = 30, 30 + i * 60
        w, h = (game.board.size - 1) * 60, 0
        stroke rgb(180, 0, 0)
        line x, y, x + w, y + h
        line y, x, y + h, x + w
      end
    end

    # Draw pairs
    game.pairs.each do |pair|
      
    end
  end
end
