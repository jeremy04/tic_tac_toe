class Board
  attr_reader :board, :winner

  def initialize
    @board = Array.new(9).map { |x| "_" }
    @history = []
    @winner = nil
  end

  def self.calculate_possible_moves(board)
    data = board.board
    moves = []
    data.each_with_index do |v,i|
      if v == "_" then moves << i end
    end
    moves
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
