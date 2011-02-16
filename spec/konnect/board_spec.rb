require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Konnect::Board do
  it "should find paths" do
    board = Konnect::Board.new 3
    board.fill_in_pairs [
      Konnect::Pair.new('A', 0, 0, 0, 2)
    ]
    
    paths = board.find_paths
    
    paths.size.should == 1
    paths[0].first.x.should == 0
    paths[0].first.y.should == 0
    paths[0].last.x.should == 0
    paths[0].last.y.should == 2
  end
end
