require File.dirname(__FILE__) + '/board'

class AI
  attr_reader :marker
  def initialize(marker, maxPly = -1)
    @maxPly = maxPly
    @marker = marker
    marker == "X" ? @opponent = "O" : @opponent = "X"
  end

  def calc_move(board)
    move, score = max(board, @maxPly)
    move
  end

  def max(board, ply)
    best_score = nil
    best_move = nil
    possible_moves = Board.calculate_possible_moves(board.dup)
    possible_moves.each do |m|
      board.set_marker(m, @marker)
      if ply == 0 or board.game_over?
        score = score_board(board.dup)
      else
        move, score = min(board.dup, ply-1)
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
    possible_moves = Board.calculate_possible_moves(board.dup)
    possible_moves.each do |m|
      board.set_marker(m, @opponent)
      if ply == 0 or board.game_over?
        score = score_board(board.dup)
      else
        move, score = max(board.dup, ply-1)
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
