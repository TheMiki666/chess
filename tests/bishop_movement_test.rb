require_relative "../lib/bishop"
require_relative "../lib/board"

board=Chess::Board.new
board.spawn_new_piece('B', 1, 4, 4)
board.draw_board
bishop=board.get_piece(4,4)
p bishop

#Test legal movements
bishop.move(7,7,board)
board.draw_board #correct
bishop.move(6,8,board)
board.draw_board #correct
bishop.move(2,4,board)
board.draw_board #correct

#Test ilegal movements
bishop.move(3,4,board)
board.draw_board #correct, doesn't move
bishop.move(4,8,board)
board.draw_board #correct, doesn't move

board.spawn_new_piece('Q', 0, 4, 6)
board.draw_board

#Cannot pass through the new piece
bishop.move(5,7,board)
board.draw_board #correct, doesn't move

#Cannot pass capture the new piece
bishop.move(4,6,board)
board.draw_board #correct

#And now can move to the square it wanted 
bishop.move(5,7,board)
board.draw_board #correct

board.spawn_new_piece('Q', 1, 8, 4)
board.draw_board

#Cannot capture the new piece
bishop.move(8,4,board)
board.draw_board #correct, it cannot