require_relative ('../lib/board')
def visual_analysis(board, color)
  puts "abcdefgh"
  (1..8).each do |i|
    x = 9 - i
    (1..8).each do |y|
      if board.analize_check(y,x,color)
        print "x".colorize(:red)
      else
        print " "
      end
    end
    puts "|".concat(x.to_s)
  end
  puts "abcdefgh"
end

#This test must show the menaced squares
board = Chess::Board.new
board.spawn_new_piece('Q', 0, 7, 7)
board.spawn_new_piece('K', 0, 7, 6)
board.spawn_new_piece('R', 1, 3, 7)
board.draw_board

board.visual_check_analysis(0) #Correct

board = Chess::Board.new
board.initial_position
board.draw_board
board.visual_check_analysis(0) #Correct
board.visual_check_analysis(1) #Correct

board = Chess::Board.new
board.spawn_new_piece('B', 1, 2, 4)
board.spawn_new_piece('B', 1, 7, 4)
board.draw_board
board.visual_check_analysis(1) #Correct

board = Chess::Board.new
board.spawn_new_piece('P', 0, 1, 2)
board.spawn_new_piece('P', 0, 2, 3)
board.spawn_new_piece('P', 0, 3, 2)
board.spawn_new_piece('P', 0, 4, 4)
board.spawn_new_piece('P', 0, 6, 3)
board.spawn_new_piece('P', 0, 6, 2)
board.spawn_new_piece('P', 0, 7, 2)
board.spawn_new_piece('P', 0, 8, 3)
board.draw_board
board.visual_check_analysis(0) #Correct

board = Chess::Board.new
board.spawn_new_piece('P', 1, 1, 2)
board.spawn_new_piece('P', 1, 2, 3)
board.spawn_new_piece('P', 1, 3, 2)
board.spawn_new_piece('P', 1, 4, 4)
board.spawn_new_piece('P', 1, 6, 3)
board.spawn_new_piece('P', 1, 6, 2)
board.spawn_new_piece('P', 1, 7, 2)
board.spawn_new_piece('P', 1, 8, 3)
board.draw_board
board.visual_check_analysis(1) #Correct

board = Chess::Board.new
board.spawn_new_piece('b', 1, 5, 5)
board.spawn_new_piece('N', 1, 4, 2)
board.spawn_new_piece('k', 1, 7, 6)
board.spawn_new_piece('k', 0, 3, 6)
board.draw_board
board.visual_check_analysis(1) #Correct
board.visual_check_analysis(0) #Correct


