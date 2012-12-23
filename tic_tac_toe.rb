#!/bin/ruby

# Complete the function below to print 2 integers separated by a single space which will be your next move

class Board
  attr_reader :board, :winner
  attr_accessor :history
  
  def initialize
    @board = Array.new(9).map { |x| "_" }
    @history = []
    @winner = nil
  end
  
  def set_marker(pos, marker)
    @board[pos] = marker
    @history << pos
  end
  
  def undo
    pos = @history.pop
    @board[pos] = "_"
    @winner = nil
  end
  
  def set_board_data(board)
    @history = []
    @board = board
  end
  
  def display
    [0, 3, 6].each do |i|
      output = ""
      for j in (0...3)
        symbol = @board[i+j]
        output += "| #{symbol}"
      end
      puts output + " |"
    end
    puts ""
  end

  def game_over?
    lines = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    lines.each do |line|
      a,b,c = line
      next if @board[a] == "_"
      if (@board[a] == @board[b]) && (@board[b] == @board[c])
        @winner = @board[a] 
        return true
      end
    end
    if @board.select { |x| x == "_" }.size == 0 
      @winner = "_"
      return true
    end
    false
  end
end


def calculate_possible_moves(board)
  data = board.board
  moves = []
  data.each_with_index do |v,i|
    if v == "_" then moves << i end
  end
  moves
end

class AI
  attr_reader :marker
  def initialize(marker, maxPly = -1)
    @maxPly = maxPly
    @marker = marker
    if marker == "X" then @opponent = "O"  else @opponent = "X" end
  end
  
  def first_move?(board)
    board.reject { |x| x == "_" }.size == 1
  end
  
  def calc_move(board)
    if @maxPly == 1 and first_move?(board.board) and board.board[4] == "_"
      move = 4
    else
      move, score = max(board, @maxPly)
    end
    move
  end
  
  def max(board, ply)
    best_score = nil
    best_move = nil
    possible_moves = calculate_possible_moves(board)
    possible_moves.each do |m|
      board.set_marker(m, @marker)
      if ply == 0 or board.game_over?
        score = score_board(board)
      else
        move, score = min(board, ply-1)
      end
      board.undo
      
      if (best_score.nil?) or (score > best_score)
        best_score = score
        best_move = m
      end
    end
    [best_move, best_score]
  end
  
  def min(board, ply)
    best_score = nil
    best_move = nil
    possible_moves = calculate_possible_moves(board)
    possible_moves.each do |m|
      board.set_marker(m, @opponent)
      if ply == 0 or board.game_over?
        score = score_board(board)
      else
        move, score = max(board, ply-1)
      end
      board.undo
      if (best_score.nil?) or (score < best_score)
        best_score = score
        best_move = m
      end
    end
    [best_move, best_score]
  end
  
  def score_board(board)
    if board.game_over?
      if board.winner == @marker
        return 1
      elsif board.winner == @opponent
        return -1
      end
    end
    return 0
  end
end


def next_move(player,board)
    if player == "X"
      the_player = AI.new(player)
    else
      the_player = AI.new(player, 1)
    end
    id = the_player.calc_move(board)
    x = (id / 3)
    y = (id % 3)
    print "#{x} #{y}"
end
#If player is X, I'm the first player.
#If player is O, I'm the second player.
player = gets.chomp

#Read the board now. The board is a 3x3 array filled with X, O or _.
board = Array.new(3) { gets.scan /\w/ }
boards = Board.new
boards.set_board_data(board.flatten)
next_move(player,boards)    
