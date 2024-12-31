require_relative "../lib/queen"
require_relative "../lib/board"

board=Chess::Board.new
board.spawn_new_piece('Q', 0, 4, 4)
board.draw_board
queen=board.get_piece(4,4)
p queen

board.spawn_new_piece('P', 1, 3, 7)
board.spawn_new_piece('P', 1, 4, 7)
board.spawn_new_piece('P', 1, 5, 7)
board.spawn_new_piece('K', 0, 5, 1)
board.draw_board

#legal movements
queen.move(5,3, board)
board.draw_board #correct

queen.move(5,7, board)
board.draw_board #correct

queen.move(4,8, board)
board.draw_board #correct

queen.move(1,8, board)
board.draw_board #correct

queen.move(8,1, board)
board.draw_board #correct

queen.move(6,1, board)
board.draw_board #correct

#ilegal movements
queen.move(5,1, board)
board.draw_board #correct, didn't move

queen.move(1,1, board)
board.draw_board #correct, didn't move

queen.move(2,4, board)
board.draw_board #correct, didn't move

queen.move(8,8, board)
board.draw_board #correct, didn't move

#legal movement
queen.move(6,4, board)
board.draw_board #correct

#ilegal movement
queen.move(2,8, board)
board.draw_board #correct, din't move

#legal movements
queen.move(3,7, board)
board.draw_board #correct
queen.move(2,8, board)
board.draw_board #correct