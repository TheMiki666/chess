require_relative("../lib/referee")

board = Chess::Board.new
referee = Chess::Referee.new(board, nil)
referee.new_match
board.clear_board
board.spawn_new_piece('K',0,1,1)
board.spawn_new_piece('K',1,8,8)
board.spawn_new_piece('R',1,1,8)
board.spawn_new_piece('R',1,2,8)
board.draw_board
print "Check: "
p referee.is_king_in_check?(0) #correct, TRUE
print "Stalemate: "
p referee.is_stalemate?(0) #correct, TRUE
print "Mate:"
p referee.is_check_mate?(0) #correct, TRUE

board.spawn_new_piece('R',0,7,2)
board.draw_board
print "Check: "
p referee.is_king_in_check?(0) #correct, TRUE
print "Stalemate: "
p referee.is_stalemate?(0) #correct, FALSE
print "Mate:"
p referee.is_check_mate?(0) #correct, FALSE

referee.new_match
board.clear_board
board.spawn_new_piece('K',0,1,1)
board.spawn_new_piece('K',1,8,8)
board.spawn_new_piece('P',1,8,7)
board.spawn_new_piece('P',1,7,7)
board.spawn_new_piece('P',0,8,6)
board.spawn_new_piece('n',1,7,8)
board.spawn_new_piece('R',0,1,8)
board.spawn_new_piece('b',0,2,2)
board.switch_turn
board.draw_board
print "Check: "
p referee.is_king_in_check?(1) #correct, FALSE
print "Stalemate: "
p referee.is_stalemate?(1) #correct, TRUE
print "Mate:"
p referee.is_check_mate?(1) #correct, FALSE

board.spawn_new_piece('N',0,6,7)
board.draw_board
print "Check: "
p referee.is_king_in_check?(1) #correct, TRUE
print "Stalemate: "
p referee.is_stalemate?(1) #correct, TRUE
print "Mate:"
p referee.is_check_mate?(1) #correct, TRUE

#Lion's mate
referee.new_match
board.change_position(7,2,7,4)
board.change_position(5,7,5,5)
board.change_position(6,2,6,3)
board.change_position(4,8,8,4)
board.draw_board
p referee.is_check_mate?(0) #Correct, MATE

referee.new_match
board.clear_board
board.spawn_new_piece('K',1,4,8)
board.spawn_new_piece('q',0,4,7)
board.spawn_new_piece('K',0,5,6)
board.switch_turn
board.draw_board
p referee.is_check_mate?(1) #Correct, MATE



