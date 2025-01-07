require_relative "../lib/game_manager"

gm = Chess::GameManager.new
board = gm.board
referee = gm.referee
ui = gm.ui

#With a non finished game
log=[
{:col1=>5, :row1=>2, :col2=>5, :row2=>4},
{:col1=>1, :row1=>7, :col2=>1, :row2=>6},
{:col1=>6, :row1=>1, :col2=>3, :row2=>4},
{:col1=>1, :row1=>8, :col2=>1, :row2=>7},
{:col1=>4, :row1=>1, :col2=>6, :row2=>3},
{:col1=>1, :row1=>6, :col2=>1, :row2=>5}] #correct

#Same, but it's black player turn
log=[
{:col1=>5, :row1=>2, :col2=>5, :row2=>4},
{:col1=>1, :row1=>7, :col2=>1, :row2=>6},
{:col1=>6, :row1=>1, :col2=>3, :row2=>4},
{:col1=>1, :row1=>8, :col2=>1, :row2=>7},
{:col1=>4, :row1=>1, :col2=>6, :row2=>3}] #correct

#With a finished game
log=[
{:col1=>5, :row1=>2, :col2=>5, :row2=>4},
{:col1=>1, :row1=>7, :col2=>1, :row2=>6},
{:col1=>6, :row1=>1, :col2=>3, :row2=>4},
{:col1=>1, :row1=>8, :col2=>1, :row2=>7},
{:col1=>4, :row1=>1, :col2=>6, :row2=>3},
{:col1=>1, :row1=>6, :col2=>1, :row2=>5},
{:col1=>3, :row1=>4, :col2=>6, :row2=>7},
{:end=>true}] #Correct

#Trying to continue a match after the mate
log=[
{:col1=>5, :row1=>2, :col2=>5, :row2=>4},
{:col1=>1, :row1=>7, :col2=>1, :row2=>6},
{:col1=>6, :row1=>1, :col2=>3, :row2=>4},
{:col1=>1, :row1=>8, :col2=>1, :row2=>7},
{:col1=>4, :row1=>1, :col2=>6, :row2=>3},
{:col1=>1, :row1=>6, :col2=>1, :row2=>5},
{:col1=>3, :row1=>4, :col2=>6, :row2=>7},
{:col1=>5, :row1=>8, :col2=>6, :row2=>7},
{:col1=>6, :row1=>3, :col2=>6, :row2=>7}] #Capturing the king!
                                            #It does not continue after the mate, correct
                                            
#Doing ilegal movements (except the first ones)
log=[
{:col1=>5, :row1=>2, :col2=>5, :row2=>4},
{:col1=>1, :row1=>7, :col2=>1, :row2=>6},
{:col1=>8, :row1=>4, :col2=>7, :row2=>4},
{:col1=>5, :row1=>7, :col2=>5, :row2=>5},
{:col1=>1, :row1=>1, :col2=>2, :row2=>1},
{:col1=>1, :row1=>1, :col2=>1, :row2=>1},
{:col1=>5, :row1=>1, :col2=>7, :row2=>1}] #Correct, it is still movement 2 player white turn

#With castling
log=[
{:col1=>5, :row1=>2, :col2=>5, :row2=>3},
{:col1=>5, :row1=>7, :col2=>5, :row2=>6},
{:col1=>2, :row1=>1, :col2=>1, :row2=>3},
{:col1=>7, :row1=>8, :col2=>6, :row2=>6},
{:col1=>4, :row1=>1, :col2=>8, :row2=>5},
{:col1=>6, :row1=>8, :col2=>1, :row2=>3},
{:col1=>4, :row1=>2, :col2=>4, :row2=>4},
{:col1=>5, :row1=>8, :col2=>7, :row2=>8},
{:col1=>3, :row1=>1, :col2=>4, :row2=>2},
{:col1=>1, :row1=>7, :col2=>1, :row2=>6},
{:col1=>5, :row1=>1, :col2=>3, :row2=>1}] #correct
  
#With captures en passant
log=[
{:col1=>1, :row1=>2, :col2=>1, :row2=>4},
{:col1=>8, :row1=>7, :col2=>8, :row2=>5},
{:col1=>1, :row1=>4, :col2=>1, :row2=>5},
{:col1=>8, :row1=>5, :col2=>8, :row2=>4},
{:col1=>7, :row1=>2, :col2=>7, :row2=>4},
{:col1=>8, :row1=>4, :col2=>7, :row2=>3},
{:col1=>1, :row1=>1, :col2=>1, :row2=>2},
{:col1=>2, :row1=>7, :col2=>2, :row2=>5},
{:col1=>1, :row1=>5, :col2=>2, :row2=>6}] #correct

#With pawn promotions
log=[
  {:col1=>2, :row1=>2, :col2=>2, :row2=>4},
  {:col1=>6, :row1=>7, :col2=>6, :row2=>5},
  {:col1=>2, :row1=>4, :col2=>2, :row2=>5},
  {:col1=>6, :row1=>5, :col2=>6, :row2=>4},
  {:col1=>2, :row1=>5, :col2=>2, :row2=>6},
  {:col1=>6, :row1=>4, :col2=>6, :row2=>3},
  {:col1=>2, :row1=>6, :col2=>3, :row2=>7},
  {:col1=>6, :row1=>3, :col2=>7, :row2=>2},
  {:col1=>3, :row1=>7, :col2=>4, :row2=>8, :promotion=>"N"},
  {:col1=>7, :row1=>2, :col2=>6, :row2=>1, :promotion=>"R"}] #correct

referee.update_board(log)
p board.get_log
referee.print_log
referee.game_loop