require File.expand_path(File.dirname(__FILE__) + "/lib/konnect")

def draw_board
  clear do
    background black
    stack margin: 10 do
      fill rgb(0, 90, 0)
      rect left: 0, top: 0, width: 540, height: 540
      
      0.upto(9) do |i|
        x, y = 30, 30 + i * 60
        w, h = 480, 0
        stroke rgb(180, 0, 0)
        line x, y, x + w, y + h
        line y, x, y + h, x + w
      end
    end
  end
end

Shoes.app width: 560, height: 560 do
  draw_board
end
