require 'rspec'
require File.dirname(__FILE__) + '/../lib/board'
require File.dirname(__FILE__) + '/../lib/ai'

describe AI do
  let(:board) { Board.new }
  let(:ai) { AI.new('O', 1) }

  it "should block the opponent" do
    state = [ ['X', 'O', '_'],
              ['X', '_', '_'],
              ['_', '_', '_']]

    board.set_board_data(state.flatten)
    ai.calc_move(board).should == 6
  end

  it "should pick the right corner" do
    ai = AI.new("O")
    state = [ ['O', '_', '_'],
              ['_', 'X', '_'],
              ['_', '_', 'X']]

    board.set_board_data(state.flatten)
    ai.calc_move(board).should == 2
  end
end


describe Board do
  let(:board) { Board.new }

  it "vertical game over" do
    data  = [ "X", "_", "_",
              "X", "_", "_",
              "X", "_", "_" ]
    board.set_board_data(data)
    board.game_over?.should be_true
  end

  it "diagonal 1 game over" do
    data  = [ "X", "_", "_",
              "_", "X", "_",
              "_", "_", "X" ]
    board.set_board_data(data)
    board.game_over?.should be_true
  end

  it "diagonal 2 game over" do
    data  = [ "_", "_", "O",
              "_", "O", "_",
              "O", "_", "_" ]
    board.set_board_data(data)
    board.game_over?.should be_true
  end

  it "tie - game over" do
    data  = [ "O", "X", "X",
              "X", "O", "O",
              "X", "O", "X" ]
    board.set_board_data(data)
    board.game_over?.should be_true
    board.winner.should == "_"
  end
end