require_relative '../lib/user_interface'

board = Chess::Board.new
ui = Chess::UserInterface.new(board, nil)
board.new_match

ui.instructions #ok
#Test ask for promotion
#p ui.ask_for_promotion  #Correctly tested

#p ui.ask_for_movement #Correctly tested
ui.message("Awful movement!") #ok
ui.error_message("Awful movement!") #ok
ui.warn_message("Awful movement!") #ok
ui.mate_message #ok
ui.check_message #ok
board.switch_turn
ui.mate_message #ok
ui.check_message #ok