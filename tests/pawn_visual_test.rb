require_relative "../lib/pawn"
require_relative "../lib/board"

board=Chess::Board.new
board.spawn_new_piece('P', 0, 3, 2)
board.draw_board
pawn=board.get_piece(3,2)
p pawn #status = 0 -> correct

pawn.move(3,4, board)
board.draw_board #correct movements
p pawn #status = 2 -> correct

pawn.move(3,5, board)
board.draw_board #correct movements
p pawn #status = 1 -> correct

pawn.move(3,6, board)
board.draw_board #correct movements
p pawn #status = 1 -> correct

#Ilegal movements
pawn.move(3,5, board)
board.draw_board #correct, didn't move
pawn.move(3,8, board)
board.draw_board #correct, didn't move
pawn.move(2,7, board)
board.draw_board #correct, didn't move
pawn.move(4,7, board)
board.draw_board #correct, didn't move

board.spawn_new_piece('N', 1, 3, 7)
board.spawn_new_piece('B', 1, 2, 7)
board.spawn_new_piece('R', 1, 3, 8)
board.draw_board

pawn.move(3,7, board)
board.draw_board #correct, didn't move

pawn.move(2,7, board)
board.draw_board #correct
pawn.move(3,8, board)
board.draw_board #correct

#PAWN PROMOTION NOT IMPLEMENTED YET

board=Chess::Board.new
board.spawn_new_piece('P', 1, 7, 7)
board.draw_board
pawn=board.get_piece(7,7)
p pawn #status = 0 -> correct
pawn.move(7,6, board)
board.draw_board #correct
p pawn #status = 1 -> correct

pawn.move(7,4, board)
board.draw_board #correct, didn't move
board.spawn_new_piece('R', 0, 8, 7)
board.spawn_new_piece('R', 0, 6, 7)
board.spawn_new_piece('R', 0, 8, 5)
board.spawn_new_piece('R', 0, 6, 5)
board.draw_board

pawn.move(8, 7, board)
board.draw_board #correct, didn't move
pawn.move(6, 7, board)
board.draw_board #correct, didn't move
pawn.move(8, 5, board)
board.draw_board #correct

#EN_PASSANT TESTS
board=Chess::Board.new
board.spawn_new_piece('P', 0, 4, 2)
board.spawn_new_piece('P', 1, 5, 4)
board.draw_board
pawn_w=board.get_piece(4,2)
pawn_b=board.get_piece(5,4)

#Black pawn can't capture yet
pawn_b.move(4,3,board)
board.draw_board #correct, didn't move

#Correct capture
pawn_w.move(4,4,board)
board.draw_board
pawn_b.move(4,3,board)
board.draw_board #CORRECT MOVEMENT (white pawn dissapearing not implemented yet)

board=Chess::Board.new
board.spawn_new_piece('P', 0, 5, 5)
board.spawn_new_piece('P', 1, 6, 7)
board.draw_board
pawn_w=board.get_piece(5,5)
pawn_b=board.get_piece(6,7)

#Correct capture
pawn_b.move(6,5,board)
board.draw_board
pawn_w.move(6,6,board)
board.draw_board #CORRECT MOVEMENT (black pawn dissapearing not implemented yet)

board=Chess::Board.new
board.spawn_new_piece('P', 0, 5, 5)
board.spawn_new_piece('P', 1, 6, 5)
board.draw_board
pawn_w=board.get_piece(5,5)
pawn_b=board.get_piece(6,5)

#Incorrect capture
pawn_w.move(6,6,board)
board.draw_board #Correct, white pawn didn't move

board=Chess::Board.new
board.spawn_new_piece('P', 0, 5, 5)
board.spawn_new_piece('P', 1, 6, 7)
board.draw_board
pawn_w=board.get_piece(5,5)
pawn_b=board.get_piece(6,7)

pawn_b.move(6,5,board)
board.draw_board
#Now we wait a turn
pawn_b.remove_en_passant
#And now we shoudn't be able to capture the pawn en passant
pawn_w.move(6,6,board)
board.draw_board #Correct, it did't move

board=Chess::Board.new
board.spawn_new_piece('P', 0, 5, 5)
board.spawn_new_piece('R', 1, 6, 7)
board.draw_board
pawn_w=board.get_piece(5,5)
pawn_b=board.get_piece(6,7)

#Incorrect capture (only pawn can be captured en passant)
pawn_b.move(6,5,board)
board.draw_board
pawn_w.move(6,6,board)
board.draw_board #CORRECT (the pawn didn't move)
