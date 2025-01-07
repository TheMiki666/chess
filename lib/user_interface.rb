require_relative "board"
require "colorize"

module Chess
  class UserInterface
    ORD_CONSTANT = 96

    def initialize(board, game_manager)
      @board = board
      @game_manager = game_manager
    end

    def warn_message(message)
      puts message.colorize(:yellow)
    end

    def error_message(message)
      puts message.colorize(:red)
    end

    def message(message)
      puts message
    end

    def stalemate_message
      puts ("Player #{player} is in stalemate!").colorize(:yellow)
    end

    def check_message
      puts ("Player #{player}, you're in check!").colorize(:yellow)
    end

    def mate_message
      puts ("Player #{player}, you're in check mate!").colorize(:red)
      @board.switch_turn
      puts ("Player #{player} wins the match!").colorize(:green)
      @board.switch_turn
    end
    
    #TESTED
    #Translates the player input to a movement
    #Returns a has with 2 squares: {[:col1],[:row1],[:col2],[:row2]}
    #Returns nil if the input has no sense
    def parse_input(string)
      string = string.downcase.strip.chomp
      if string == "o-o"
        castling('s') #short
      elsif string == "o-o-o"
        castling('l') #long
      else
        string = string[0..4] if string.length == 6 && string[5]=="+" #remove the check symbol
        return nil if string.length != 5
        extract_movement(string)
      end
    end

    #TESTED
    def ask_for_movement
      loop do
        answer = 1
        puts "Player #{player}, is your turn."
        puts "Enter your movement:"
        input = gets.chomp.strip.downcase
        puts
        if input == 'log'
          @game_manager.print_log(false) #Change false to true if you, developer, want to see the true log
          answer = 0
        elsif input == 'board'
          @board.draw_board
          answer = 0
        elsif input == 'save'
          puts "Calling save" #TODO: Replace for the function call
          answer = 0
        elsif input == 'draw'
          answer = @game_manager.draw_requirement(@board.player_turn)
        elsif input == 'resign'
          answer = @game_manager.resign_requirement(@board.player_turn)
        elsif input == 'quit'
          answer = @game_manager.quit_requirement
        else
          answer = parse_input(input)
        end
        return answer if !answer.nil? && answer !=0 
        if answer.nil?
          puts "Input not correct.".colorize(:red)
          instructions
        end
      end
    end

    #TESTED
    def instructions
      puts "Enter your movements with algebraic notation."
      puts "For example: c1-d4"
      puts "It is accepted, but not necessary, the capture symbol:"
      puts "c1xd4"
      puts "...or check symbol:"
      puts "c1xd4+"
      puts "or even castling notation:"
      puts "O-O or O-O-O"
      puts "Enter 'save' to save the match."
      puts "Enter 'board' to see the board."
      puts "Enter 'log' to see the log of the match moves."
      puts "Enter 'draw' to offer a draw to your opponent or claim it."
      puts "Enter 'resign' to resign the match."
      puts "Enter 'quit' to leave the program."
    end

    # TESTED
    def ask_for_promotion
      loop do
        puts "Player #{player}, your pawn has ".concat("promoted!").colorize(:green)
        puts "Which piece do you want to promote to (Queen recommended)?"
        puts "'Q' = Queen, 'R' = Rook, 'B' = Bishop, 'N' = Knight"
        answer = gets.chomp.strip.upcase
        puts
        return answer if answer == 'Q' || answer == 'R' || answer == 'B' || answer == 'N'
        if answer == 'P'
          puts "The pawn can not promote to another pawn!".colorize(:red)
        elsif answer == 'K'
          puts "The pawn can not promote to King!".colorize(:red)
        else
          puts "Input not correct".colorize(:red)
        end
      end
    end

    def yes_no(message)
      loop do
        print message
        puts "? (yes/no)"
        answer = gets.chomp.strip.downcase
        return true if answer == "y" || answer == "yes"
        return false if answer == "n" || answer == "no"
      end
    end

    private

    def player
      @board.player_turn == 0 ? "White" : "Black"
    end

    #TESTED
    def extract_movement(string)
      col1 = string[0].ord - ORD_CONSTANT
      row1 = string[1].to_i
      col2 = string[3].ord - ORD_CONSTANT
      row2 = string[4].to_i
      return nil if !row1.is_a?(Integer) || !row2.is_a?(Integer)
      return nil if !col1.between?(1,8) || !col2.between?(1,8) || !row1.between?(1,8) || !row2.between?(1,8)
      {col1: col1, row1: row1, col2: col2, row2: row2}
    end

    # The user intends to castle explicitly
    def castling (mode)
      if @board.player_turn == 0
        if mode == 's'
          {col1: 5, row1: 1, col2: 7, row2: 1, castle: true}
        else #'l'
          {col1: 5, row1: 1, col2: 3, row2: 1, castle: true}
        end
      else #board.player_turn == 1
        if mode == 's'
          {col1: 5, row1: 8, col2: 7, row2: 8, castle: true}
        else #'l'
          {col1: 5, row1: 8, col2: 3, row2: 8, castle: true}
        end
      end
    end

  end
end