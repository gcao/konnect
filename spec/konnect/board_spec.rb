require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Konnect::Board do
  it "should find paths for one pair which are neighbors (should not happen in reality)" do
    board = Konnect::Board.new 3
    board.fill_in_pairs [
      Konnect::Pair.new('A', 0, 0, 0, 1)
    ]
    
    paths = board.find_paths
    
    paths.size.should == 1
    paths[0].first.x.should == 0
    paths[0].first.y.should == 0
    paths[0].last.x.should == 0
    paths[0].last.y.should == 1
  end

  it "should find paths for one pair" do
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

  it "should find paths for 2 pairs" do
    board = Konnect::Board.new 3
    board.fill_in_pairs [
      Konnect::Pair.new('A', 0, 0, 0, 2),
      Konnect::Pair.new('B', 1, 0, 1, 2),
    ]

    paths = board.find_paths

    paths.size.should == 2
    paths[0].first.x.should == 0
    paths[0].first.y.should == 0
    paths[0].last.x.should == 0
    paths[0].last.y.should == 2
    paths[1].first.x.should == 1
    paths[1].first.y.should == 0
    paths[1].last.x.should == 1
    paths[1].last.y.should == 2
  end

  it "should raise no path error" do
    board = Konnect::Board.new 3
    board.fill_in_pairs [
      Konnect::Pair.new('A', 1, 0, 1, 2),
      Konnect::Pair.new('B', 0, 1, 2, 1),
    ]

    lambda {
      paths = board.find_paths
    }.should raise_error Konnect::NoPathError
  end
end
