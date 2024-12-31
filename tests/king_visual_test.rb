require_relative "../lib/king"
require_relative "../lib/board"

board=Chess::Board.new
board.spawn_new_piece('K', 0, 3, 3)
board.draw_board
king=board.get_piece(3,3)
p king #status = 0, correct

#Make a legal move
king.move(4,4,board)
board.draw_board
p king #status = 1 now, correct

#Make a another legal move
king.move(5,4,board)
board.draw_board
p king #status = 1 still, correct

#Make more legal movements
king.move(6,3,board)
board.draw_board #ok

king.move(6,2,board)
board.draw_board #ok

king.move(5,1,board)
board.draw_board #ok

#Cannot castle (for the moment)
king.move(7,1,board)
board.draw_board #did't move, correct

king.move(3,1,board)
board.draw_board #did't move, correct

#Make more legal movements
king.move(4,1,board)
board.draw_board #ok

king.move(3,2,board)
board.draw_board #ok

king.move(3,3,board)
board.draw_board #ok

#Cannot make ilegal movements
king.move(8,1,board)
board.draw_board #ok, didn't move
king.move(8,8,board)
board.draw_board #ok, didn't move
king.move(5,4,board)
board.draw_board #ok, didn't move

board.spawn_new_piece('B', 1, 4, 3)
board.spawn_new_piece('R', 1, 5, 4)
board.spawn_new_piece('P', 0, 5, 5)
board.draw_board 

#Can capture enemies
king.move(4,3,board)
board.draw_board #ok
king.move(5,4,board)
board.draw_board #ok

#Can't capure allies
king.move(5,5,board)
board.draw_board #ok, not moved