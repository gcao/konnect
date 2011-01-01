require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Konnect" do
  it "should find paths for pairs" do
    game = Konnect::Game.new 6, [
        Konnect::Pair.new('A', 1, 1, 3, 3),
        Konnect::Pair.new('B', 2, 2, 4, 4)
    ]

    game.find_paths

    path0 = game.pairs[0].path
    path0.first.should == [1, 1]
    path0.last.should == [3, 3]

    path1 = game.pairs[1].path
    path1.first.should == [2, 2]
    path1.last.should == [4, 4]

    path0.has_common_point?(path1).should be_false
  end
end
