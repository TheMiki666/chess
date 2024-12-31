require_relative "../lib/knight"
require_relative "../lib/board"

board=Chess::Board.new
board.spawn_new_piece('N', 1, 4, 4)
board.draw_board
knight=board.get_piece(4,4)
p knight

#Make some legal movements
knight.move(5,6, board)
board.draw_board #Correct movement
knight.move(6, 8, board)
board.draw_board #Correct movement
knight.move(7, 6, board)
board.draw_board #Correct movement
knight.move(8, 8, board)
board.draw_board #Correct movement

#Raises an error when moving to an inexistent square
#knight.move(9, 10, board) #ok, rises it

#Jumps over other pieces
board.spawn_new_piece('B', 1, 7, 7)
board.spawn_new_piece('R', 0, 7, 8)
board.spawn_new_piece('P', 0, 8, 7)
board.draw_board 
knight.move(6, 7, board)
board.draw_board 
knight.move(7, 5, board)
board.draw_board 

#Cant make ilegal movements
knight.move(7, 5, board)
board.draw_board #Same square
knight.move(1, 1, board)
board.draw_board #Didn't move
knight.move(5, 7, board)
board.draw_board #Didn't move

#Can capture enemy pieces
knight.move(8, 7, board)
board.draw_board #Correct movement
knight.move(6, 6, board)
board.draw_board #Correct movement
knight.move(7, 8, board)
board.draw_board #Correct movement
knight.move(6, 6, board)
knight.move(8, 5, board)
board.draw_board

#Can't capture pieces of the same color
knight.move(7, 7, board)
board.draw_board #Didn't move

#All tests correct