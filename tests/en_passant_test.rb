require_relative('../lib/referee')

board = Chess::Board.new
ui = Chess::UserInterface.new(board, nil)
referee = Chess::Referee.new(board, ui)
referee.new_match
board.clear_board
board.spawn_new_piece('K',0,5,1)
board.spawn_new_piece('K',1,5,8)
(0..3).each do |i|
  board.spawn_new_piece('P',0,1 + i*2,5)
  board.spawn_new_piece('P',1,2 + i*2,7)
  board.spawn_new_piece('P',0,1 + i*2,2)
  board.spawn_new_piece('P',1,2 + i*2,4)
end

#Uncomment this if you want to check that only pawns can capture other pawns en passant
#board.spawn_new_piece('R',1,8,3)

referee.game_loop