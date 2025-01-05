require_relative('../lib/referee')

board = Chess::Board.new
ui = Chess::UserInterface.new(board, nil)
referee = Chess::Referee.new(board, ui)
referee.new_match

#Free castling
(2..4).each do |y|
  board.remove_piece(y,1)
  board.remove_piece(y,8)
end
(6..7).each do |y|
  board.remove_piece(y,1)
  board.remove_piece(y,8)
end

#Uncomment this to put the kings in check
#board.spawn_new_piece('N', 0, 6, 6)
#board.spawn_new_piece('N', 1, 6, 3)

#Uncomment this to leave the kings in check after castling
#board.spawn_new_piece('N', 0, 8, 6)
#board.spawn_new_piece('N', 0, 2, 6)
#board.spawn_new_piece('N', 1, 8, 3)
#board.spawn_new_piece('N', 1, 2, 3)

#Uncomment this to make the kings pass through a check during castling
#board.spawn_new_piece('N', 0, 7, 6)
#board.spawn_new_piece('N', 0, 3, 6)
#board.spawn_new_piece('N', 1, 7, 3)
#board.spawn_new_piece('N', 1, 3, 3)

#Uncomment this to put obstacles in the way
#You can change the column of the obstacle
#board.spawn_new_piece('N', 0, 7, 1)
#board.spawn_new_piece('N', 1, 7, 8)

#Uncomment this to check that it doesn't matter that the rook is menaced or passes through a menaced square
#board.spawn_new_piece('B', 1, 4, 4)
#board.spawn_new_piece('R', 1, 2, 4)
#board.remove_piece(2,2)

referee.game_loop