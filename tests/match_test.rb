require_relative('../lib/referee')

board = Chess::Board.new
ui = Chess::UserInterface.new(board, nil)
referee = Chess::Referee.new(board, ui)
referee.new_match


#Uncomment this block to play king and queen vs king
#board.clear_board
#board.spawn_new_piece('K', 1, 5, 8)
#board.spawn_new_piece('K', 0, 5, 4)
#board.spawn_new_piece('Q', 0, 4, 4)

#Uncomment this block to play Deletang method
board.clear_board
board.spawn_new_piece('K', 1, 5, 8)
board.spawn_new_piece('K', 0, 5, 4)
board.spawn_new_piece('B', 0, 4, 4)
board.spawn_new_piece('N', 0, 6, 4)

#Uncomment this block to analize pawn_promotion
#board.clear_board
#board.spawn_new_piece('K', 1, 5, 8)
#board.spawn_new_piece('K', 0, 5, 4)
#board.spawn_new_piece('P', 0, 2, 7)
#board.spawn_new_piece('P', 1, 7, 2)

referee.game_loop