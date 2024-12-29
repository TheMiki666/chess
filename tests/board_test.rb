require_relative "../lib/board"

board = Chess::Board.new
board.draw_board
puts "-------"
board.initial_position
board.draw_board

