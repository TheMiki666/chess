require_relative "board"
require_relative "referee"
require_relative "user_interface"

module Chess
  class GameManager
    attr_accessor :board, :ui, :referee
    
    def initialize
      @board = Chess::Board.new
      @ui = Chess::UserInterface.new(@board, self)
      @referee = Chess::Referee.new(@board, @ui)
    end

    def new_match
      @referee.new_match
    end

    #TESTED
    def print_log(true_log=false)
      if true_log
        @board.get_log.each {|entry| p entry} #For developers
      else
        @referee.print_log #Foru users
      end
    end

    #TESTED
    def draw_requirement(player)
      player_name = (player == 0 ? "White" : "Black")
      case @referee.get_draw_situation
      when 0
        @ui.message("Player #{player_name} offers a draw.")
        rival = (player == 1 ? "White" : "Black")
        @ui.message("Player #{rival}, do yo accept the draw?")
        if @ui.yes_no
          @ui.warn_message("Draw accorded by both players.")
          return 1 #1 = Means end of match
        else
          @ui.message("Player #{rival} does not accept the draw.")
          @ui.message("Match continues.")
          return 0  #0 = Means ask for movement again
        end
      when 1
        @ui.message("Player #{player} claims a draw.")
        @ui.warn_message("There has happend more than 50 movements whitout capturing a piece or moving a pawn.")
        @ui.warn_message("Draw accepted.")
        return 1 
      end
    
    
    end
  end
end