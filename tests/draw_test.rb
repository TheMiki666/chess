require_relative "../lib/game_manager"

gm = Chess::GameManager.new
board = gm.board
referee = gm.referee
ui = gm.ui

referee.new_match
board.clear_board
board.spawn_new_piece('K', 1, 5, 8)
board.spawn_new_piece('K', 0, 5, 4)
board.spawn_new_piece('Q', 0, 4, 4)

referee.game_loop