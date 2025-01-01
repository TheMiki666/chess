require_relative "../lib/board"

board = Chess::Board.new
board.initial_position
board.draw_board
piece = board.get_piece(4,1)
board.set_piece(7,4, piece)
board.draw_board #Correct
board.set_piece(1,6, piece)
board.set_piece(2,6, piece)
board.set_piece(3,6, piece)
board.draw_board #Correct
piece = board.get_piece(4,8)
board.set_piece(7,4, piece)
board.draw_board #Correct

#rising errors
#board.set_piece(9,4, piece) #Correct
#board.set_piece(3,0, piece) #Correct
