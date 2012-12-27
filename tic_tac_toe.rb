#!/bin/ruby

# Complete the function below to print 2 integers separated by a single space which will be your next move
require File.dirname(__FILE__) + "/lib/board"
require File.dirname(__FILE__) + "/lib/ai"

def next_move(player,board)
    the_player = AI.new(player)
    best_move = the_player.calc_move(board)
    x = (best_move / 3)
    y = (best_move % 3)
    print "#{x} #{y}"
end

#If player is X, I'm the first player.
#If player is O, I'm the second player.
player = gets.chomp

#Read the board now. The board is a 3x3 array filled with X, O or _.
board = Array.new(3) { gets.scan /\w/ }
my_board = Board.new
my_board.set_board_data(board.flatten)
next_move(player, my_board)
