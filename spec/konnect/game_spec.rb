require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Konnect::Game do
  it "should find paths for pairs" do
    game = Konnect::Game.new 6, [
      Konnect::Pair.new('A', 1, 1, 3, 3),
      Konnect::Pair.new('B', 2, 2, 4, 4)
    ]

    solution = game.solve

    path0 = solution.paths[0]
    [path0.first.x, path0.first.y].should == [1, 1]
    [path0.last.x, path0.last.y].should == [3, 3]

    path1 = solution.paths[1]
    [path1.first.x, path1.first.y].should == [2, 2]
    [path1.last.y, path1.last.y].should == [4, 4]
  end
end
