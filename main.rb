require File.expand_path(File.dirname(__FILE__) + "/lib/konnect")
require File.expand_path(File.dirname(__FILE__) + "/lib/konnect/shoes")

game = Konnect::Game.generate 6, 5

g = Konnect::Shoes::GameManager.new
g.game = game
g.run