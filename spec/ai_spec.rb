require 'rspec'
require File.dirname(__FILE__) + '/../tic_tac_toe'

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
  
  it "first move should be center if its not already taken and I'm the 2nd player" do
    state = [ ['X', '_', '_'],
              ['_', '_', '_'],
              ['_', '_', '_']]
    board.set_board_data(state.flatten)
    ai.calc_move(board).should == 4
  end

end


describe Board do
    let(:board) { Board.new }
    
    it "game over" do
      data  = [ "X", "_", "_",
                "X", "_", "_",
                "X", "_", "_" ]
      board.set_board_data(data)
      board.game_over?.should be_true
    end
    
    it "game over" do
       data  = [ "X", "_", "_",
                 "_", "X", "_",
                 "_", "_", "X" ]
       board.set_board_data(data)
       board.game_over?.should be_true
     end
     
     it "game over" do
       data  = [ "_", "_", "O",
                 "_", "O", "_",
                 "O", "_", "_" ]
       board.set_board_data(data)
       board.game_over?.should be_true
     end
    
    
     it "game over" do
       data  = [ "O", "X", "X",
                 "X", "O", "O",
                 "X", "O", "X" ]
       board.set_board_data(data)
       board.game_over?.should be_true
       board.winner.should == "_"
     end
end