require_relative "../lib/user_interface"
require_relative "../lib/board"
require_relative "../lib/king"

#Testing parse_input
board = Chess::Board.new
ui = Chess::UserInterface.new(board, nil)
board.new_match
p board.player_turn
p ui.parse_input("  O-o   ") #Correct
p ui.parse_input("  O-O-O   ") #Correct
board.switch_turn
p board.player_turn
p ui.parse_input("  O-O   ") #Correct
p ui.parse_input("  O-o-O   ") #Correct

p ui.parse_input("c4-f5") #Correct
p ui.parse_input(  "A1 H8    ") #Correct
p ui.parse_input("a8xH1+  ") #Correct
p ui.parse_input("a8xH1++  ") #Returns nil, correct
p ui.parse_input("foo") #Returns nil, correct
p ui.parse_input("foooo") #Returns nil, correct
p ui.parse_input("1c-h4") #Returns nil, correct
p ui.parse_input("i7-h4") #Returns nil, correct
p ui.parse_input("b9-h4") #Returns nil, correct
p ui.parse_input("b7-i4") #Returns nil, correct
p ui.parse_input("b7-h0") #Returns nil, correct

#Trying to castle without kings
board.remove_piece(5,1)
board.remove_piece(5,8)
board.draw_board
p ui.parse_input("  O-o   ") #Returns nil, correct
p ui.parse_input("  O-O-O   ") #Returns nil, correct

board.switch_turn
p board.player_turn
p ui.parse_input("  O-o   ") #Returns nil, correct
p ui.parse_input("  O-O-O   ") #Returns nil, correct