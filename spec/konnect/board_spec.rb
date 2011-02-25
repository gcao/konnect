require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Konnect
  describe Board do
    describe "directions" do
      it "should return directions for (0,0) to (1,0)" do
        directions = Board.directions Point.new(0, 0), Point.new(1, 0)
        directions.should == [Board::EAST, Board::NORTH, Board::SOUTH, Board::WEST]
      end

      it "should return directions for (0,0) to (0,1)" do
        directions = Board.directions Point.new(0, 0), Point.new(0, 1)
        directions.should == [Board::NORTH, Board::EAST, Board::WEST, Board::SOUTH]
      end

      it "should return directions for (0,0) to (1,1)" do
        directions = Board.directions Point.new(0, 0), Point.new(1, 1)
        directions.should == [Board::EAST, Board::NORTH, Board::WEST, Board::SOUTH]
      end

      it "should return directions for (1,0) to (0,0)" do
        directions = Board.directions Point.new(1, 0), Point.new(0, 0)
        directions.should == [Board::WEST, Board::NORTH, Board::SOUTH, Board::EAST]
      end

      it "should return directions for (0,1) to (0,0)" do
        directions = Board.directions Point.new(0, 1), Point.new(0, 0)
        directions.should == [Board::SOUTH, Board::EAST, Board::WEST, Board::NORTH]
      end

      it "should return directions for (1,1) to (0,0)" do
        directions = Board.directions Point.new(1, 1), Point.new(0, 0)
        directions.should == [Board::WEST, Board::SOUTH, Board::EAST, Board::NORTH]
      end

      it "should return directions for (1,0) to (0,1)" do
        directions = Board.directions Point.new(1, 0), Point.new(0, 1)
        directions.should == [Board::WEST, Board::NORTH, Board::EAST, Board::SOUTH]
      end

      it "should return directions for (0,1) to (1,0)" do
        directions = Board.directions Point.new(0, 1), Point.new(1, 0)
        directions.should == [Board::EAST, Board::SOUTH, Board::WEST, Board::NORTH]
      end

      it "should return directions for (2,3) to (1,4)" do
        directions = Board.directions Point.new(2, 3), Point.new(1, 4)
        directions.should == [Board::WEST, Board::NORTH, Board::EAST, Board::SOUTH]
      end
    end
  
    it "should find paths for one pair which are neighbors (should not happen in reality)" do
      board = Board.new 3
      board.fill_in_pairs [
        Pair.new('A', 0, 0, 0, 1)
      ]
      
      paths = board.find_paths
      
      paths.size.should == 1
      paths[0].first.x.should == 0
      paths[0].first.y.should == 0
      paths[0].last.x.should == 0
      paths[0].last.y.should == 1
    end
  
    it "should find paths for one pair" do
      board = Board.new 3
      board.fill_in_pairs [
        Pair.new('A', 0, 0, 0, 2)
      ]
  
      paths = board.find_paths
  
      paths.size.should == 1
      paths[0].first.x.should == 0
      paths[0].first.y.should == 0
      paths[0].last.x.should == 0
      paths[0].last.y.should == 2
    end
  
    it "should find paths for 2 pairs" do
      board = Board.new 3
      board.fill_in_pairs [
        Pair.new('A', 0, 0, 0, 2),
        Pair.new('B', 1, 0, 1, 2),
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
      board = Board.new 3
      board.fill_in_pairs [
        Pair.new('A', 1, 0, 1, 2),
        Pair.new('B', 0, 1, 2, 1),
      ]
  
      lambda {
        paths = board.find_paths
      }.should raise_error NoPathError
    end
  end
end
