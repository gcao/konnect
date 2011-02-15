require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Konnect::Board do
  it "should find paths" do
    board = Board.new 3
    board.fill_in_pairs
  end
end
