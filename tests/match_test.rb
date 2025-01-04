require_relative('../lib/referee')

board = Chess::Board.new
ui = Chess::UserInterface.new(board, nil)
referee = Chess::Referee.new(board, ui)
referee.new_match


#Uncomment this block to play king and queen vs king
board.clear_board
board.spawn_new_piece('K', 1, 5, 8)
board.spawn_new_piece('K', 0, 5, 4)
board.spawn_new_piece('Q', 0, 4, 4)

referee.game_loop