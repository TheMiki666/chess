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
      @quitting = false
    end

    def start
      greeting
      loop do
        initial_options
        new_match
        @referee.game_loop
        break if @quitting
        between_matches_options
        break if @quitting
      end
        farewell
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
      puts
      player_name = (player == 0 ? "White" : "Black")
      case @referee.get_draw_situation
      when 0
        @ui.message("Player #{player_name} offers a draw.")
        rival = (player == 1 ? "White" : "Black")
        if @ui.yes_no("Player #{rival}, do yo accept the draw")
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

    def resign_requirement(player)
      puts
      player_name = (player == 0 ? "White" : "Black")
      if @ui.yes_no("Player #{player_name}, do you really want to resign") 
        rival = (player == 1 ? "White" : "Black")
        @ui.message("Player #{player_name} resigns.".colorize(:red))
        @ui.message("Player #{rival} wins the match!".colorize(:green))
        return 1 
      else 
        @ui.message("Match continues.")
        return 0
      end

    end

    def quit_requirement
      puts
      if @ui.yes_no("Do you really want to quit the game and return to O.S.")
        @quitting = true
        #TODO CALL SAVE if
          @ui.yes_no("Do you want to save the match before leaving")
        return 1 
      else 
        @ui.message("Match continues.")
        return 0
      end
    end

    def greeting
      puts
      puts "************************".colorize(:green)
      puts "*                      *".colorize(:green)
      puts "*        ODIN'S        *".colorize(:green)
      puts "*                      *".colorize(:green)
      puts "*        CHESS         *".colorize(:green)
      puts "*                      *".colorize(:green)
      puts "************************".colorize(:green)
      puts
      puts "Press 'Enter' to start"
      gets
    end

    def farewell
      puts
      @ui.message("Thanks's for playing Odin's Chess!".colorize(:green))
      @ui.message("Have a nice day!".colorize(:green))
    end

    def initial_options
      puts
      @ui.message("LET'S PLAY A NEW MATCH OF CHESS!")
      @referee.threefold = @ui.yes_no("Do you want to active the threefold an fivefold repetition draw rules (that could make the game a bit more slower)")

      #TODO: COMPROBAR SI HAY PARTIDAS GUARDADAS Y, SI LAS HAY, PREGUNTAR SI QUIERE GRABAR ALGUNA
      
      #COMPROBAR SI QUIERE JUGAR CON 1 O 2 JUGADORES
    end

    def between_matches_options
      @referee.print_log if @ui.yes_no("Do you want to see the final log")
      #TODO: SAVEMATCH if 
      @ui.yes_no("Do you want to have the match saved")
      @quitting = !@ui.yes_no("Do you want to play another match")
    end
  end
end