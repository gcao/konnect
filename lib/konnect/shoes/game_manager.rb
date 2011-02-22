# Shoes block's self is the shoes app object. It can not call methods defined outside.
# Solution: set @gm to the instance of game manager and call @gm.draw_board.
# Drawback: not very intuitive
class Konnect::Shoes::GameManager
  attr :game

  def initialize
  end

  def game= game
    @game = game
  end

  def draw_board size
    clear do
      background black
      stack margin: 10 do
        fill rgb(0, 90, 0)
        rect left: 0, top: 0, width: 540, height: 540

        0.upto(size) do |i|
          x, y = 30, 30 + i * 60
          w, h = 480, 0
          stroke rgb(180, 0, 0)
          line x, y, x + w, y + h
          line y, x, y + h, x + w
        end
      end
    end
  end

  def run
    width = height = @game.board.size * 30 + 2 * 10
    Shoes.app width: width, height: height do
      draw_board @game.board.size
    end
  end
end