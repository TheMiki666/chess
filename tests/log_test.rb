require_relative "../lib/game_manager"

gm = Chess::GameManager.new
board = gm.board
referee = gm.referee
ui = gm.ui
referee.new_match
referee.game_loop