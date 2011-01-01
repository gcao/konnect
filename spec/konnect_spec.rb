require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Konnect" do
  it "should generate a set of pairs" do
    game = Konnect::Game.new 6, 4
    game.pairs.size.should == 8
    paths = game.find_paths
    paths.size.should == 4
  end
end
