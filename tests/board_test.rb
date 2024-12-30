require_relative "../lib/board"

#Draws an empty board
board = Chess::Board.new
board.draw_board #correct
puts "-------"
#Draws an empty board
board.initial_position
board.draw_board #correct
puts "-------"
#Removes white queen
board.remove_piece(4,1)
board.draw_board #correct
#Removes a black knight
board.remove_piece(7,8)
board.draw_board #correct
#Nothing happens when trying to remove an empty square
board.remove_piece(5,6)
board.draw_board #correct
#Raises an error if the row or col is not correct
#board.remove_piece(5,9) ok
#board.remove_piece(11,4)
puts "-------"
#Spawn a white king on (1,4)
board.spawn_new_piece('k',0,1,4)
board.draw_board #correct
#Spawn a black rook on (4,1)
board.spawn_new_piece('R',1,4,1)
board.draw_board #correct
#Replace the black queen for a white queen
board.spawn_new_piece('q',0,4,8)
board.draw_board #correct
#Raises an error if the piece is not correct
#board.spawn_new_piece('S',0,5,5) #ok
#board.spawn_new_piece('Rook',0,5,5) #ok
#board.spawn_new_piece(nil,0,5,5) #ok
#Raises an error if the color is not correct
#board.spawn_new_piece('P',-1,5,5) #ok
#Raises an error if the square is not correct
#board.spawn_new_piece('B',1,5,0) #ok
puts "----"
#Get some pieces
p board.get_piece(2,7)
p board.get_piece(7,1)
p board.get_piece(1,4)
p board.get_piece(5,5) #all correct

#This must rise an error
#p board.get_piece(5,9) #ok

#Get the whole board
board.squares.each {|col| p col} #correct

#Change the position of a rook
board.change_position(8,1,8,6)
board.draw_board
p board.get_piece(8,6)
p board.get_piece(8,1) #all correct

#Capture the white king with a bishop
board.change_position(6,8,1,4)
board.draw_board
p board.get_piece(6,8)
p board.get_piece(1,4) #all correct

#Try to move an empty square (must do nothing)
board.change_position(5,5,5,8)
board.draw_board
p board.get_piece(5,5)
p board.get_piece(5,8) #all correct

#Raise some errors
# board.change_position(5,5,5,9) #ok
# board.change_position(5,nil,5,8) #ok
# board.change_position(0,5,5,8) #ok

#Finally, lets clear the board
board.clear_board
board.draw_board
p board.squares #all correct

