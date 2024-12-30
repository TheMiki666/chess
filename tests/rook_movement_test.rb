require_relative "../lib/rook"
require_relative "../lib/board"

board=Chess::Board.new
board.spawn_new_piece('R', 0, 3, 3)
board.draw_board
rook=board.get_piece(3,3)
p rook

#Make a legal move
rook.move(3,7, board)
board.draw_board #Correct movement
#Check if the status has changed to 1
p rook #Correct

#Make another legal move
rook.move(1,7, board)
board.draw_board #Correct movement
#Check if the status is still 1
p rook #Correct

#Make more legal moves
rook.move(1,1, board)
board.draw_board #Correct movement
rook.move(8,1, board)
board.draw_board #Correct movement
rook.move(8,8, board)
board.draw_board #Correct movement
rook.move(1,8, board)
board.draw_board #Correct movement
rook.move(1,5, board)
board.draw_board #Correct movement
rook.move(5,5, board)
board.draw_board #Correct movement

#Try to make ilegal movements
rook.move(5,5, board)
board.draw_board #Correct (not moved)
rook.move(7,7, board)
board.draw_board #Correct (not moved)
rook.move(4,3, board)
board.draw_board #Correct (not moved)
rook.move(3,7, board)
board.draw_board #Correct (not moved)

#Raise errors
#rook.move(5,-5, board) #ok, rises TypeError
#rook.move('f',5, board) #ok, rises TypeError

#NOW WITH OBSTACLES
board.spawn_new_piece('q', 1, 5, 2)
board.spawn_new_piece('p', 1, 2, 5)
board.spawn_new_piece('p', 0, 5, 7)
board.spawn_new_piece('k', 0, 7, 5)
board.draw_board

#Can't move passing the obstacle
rook.move(1,5, board)
board.draw_board #correct, rook doesn't move
rook.move(8,5, board)
board.draw_board #correct, rook doesn't move
rook.move(5,1, board)
board.draw_board #correct, rook doesn't move
rook.move(5,8, board)
board.draw_board #correct, rook doesn't move

#Can't capture its own pieces
rook.move(5,7, board)
board.draw_board #correct, rook doesn't move
rook.move(7,5, board)
board.draw_board #correct, rook doesn't move

#Can move stopping after the obstacle
rook.move(5,6, board)
board.draw_board #correct
rook.move(5,3, board)
board.draw_board #correct
rook.move(5,5, board)
rook.move(3,5, board)
board.draw_board #correct
rook.move(6,5, board)
board.draw_board #correct

#Can capture enemy pieces
rook.move(2,5, board)
board.draw_board #correct
rook.move(5,5, board)
board.draw_board #correct, the black pawn doesn't exist anymore
rook.move(5,2, board)
board.draw_board #correct
rook.move(5,5, board)
board.draw_board #correct, the black queen doesn't exist anymore

#ALL TESTS CORRECT