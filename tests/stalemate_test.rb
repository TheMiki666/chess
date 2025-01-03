require_relative("../lib/referee")

board = Chess::Board.new
referee = Chess::Referee.new(board, nil)
referee.new_match
board.clear_board
board.spawn_new_piece('K',0,1,1)
board.spawn_new_piece('Q',1,3,2)
board.spawn_new_piece('K',1,1,8)
board.draw_board
p referee.is_stalemate?(0) #correct, TRUE

board.spawn_new_piece('p',0,7,2)
board.spawn_new_piece('p',0,8,3)
board.spawn_new_piece('p',1,7,3)
board.spawn_new_piece('p',1,8,4)
board.draw_board
p referee.is_stalemate?(0) #correct, TRUE

board.spawn_new_piece('p',1,6,3)
board.draw_board
p referee.is_stalemate?(0) #correct, FALSE

referee.new_match
board.clear_board
board.spawn_new_piece('K',0,1,1)
board.spawn_new_piece('Q',1,4,2)
board.spawn_new_piece('K',1,1,8)
board.draw_board
p referee.is_stalemate?(0) #correct, FALSE

referee.new_match
board.clear_board
board.spawn_new_piece('K',0,1,1)
board.spawn_new_piece('K',1,4,4)
board.spawn_new_piece('R',0,3,1)
board.spawn_new_piece('R',0,5,1)
board.spawn_new_piece('R',0,1,3)
board.spawn_new_piece('R',0,1,5)
board.switch_turn
board.draw_board
p referee.is_stalemate?(1) #correct, TRUE

board.spawn_new_piece('N',1,8,8)
board.draw_board
p referee.is_stalemate?(1) #correct, FALSE

referee.new_match
board.clear_board
board.spawn_new_piece('K',0,1,1)
board.spawn_new_piece('K',1,8,8)
board.spawn_new_piece('R',0,1,8)
board.spawn_new_piece('B',0,2,2)
board.spawn_new_piece('P',0,8,6)
board.spawn_new_piece('P',1,7,7)
board.spawn_new_piece('P',1,8,7)
board.spawn_new_piece('N',1,7,8)
board.switch_turn
board.draw_board
p referee.is_stalemate?(1) #correct, TRUE

board.spawn_new_piece('P',0,8,7)
board.switch_turn
board.draw_board
p referee.is_stalemate?(1) #correct, FALSE