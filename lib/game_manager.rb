require_relative "board"
require_relative "referee"
require_relative "user_interface"
require "json"

module Chess
  class GameManager
    DIR_PATH = "saves"
    FILE_PATH = "match"
    EXTENSION_PATH = ".json"
    attr_accessor :board, :ui, :referee
    
    def initialize
      @board = Chess::Board.new
      @ui = Chess::UserInterface.new(@board, self)
      @referee = Chess::Referee.new(@board, @ui)
      @quitting = false
      Dir.mkdir(DIR_PATH) if !Dir.exist?(DIR_PATH)
    end

    def start
      greeting
      loop do
        new = initial_options
        new_match if new #else loaded match
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

    # frees_slots: true if you want to see the slots free to save in
    # false if you want to see the slots that exist
    # Returns an array with that slots
    def read_slots
      begin 
        base = String.new(DIR_PATH)
        base.concat("/").concat(FILE_PATH)
        slots = []
        (0..9).each do |n|
          path = String.new(base)
          path.concat(n.to_s).concat(EXTENSION_PATH)
          slots.push(n) if File.exist?(path)
        end
        slots 
      rescue 
        @ui.error_message("Saved matches could not be read.")
        []
      end
    end

    # Return true if match could be loaded
    def load_match
      slot = @ui.ask_for_slot(false).to_s
      path = String.new(DIR_PATH).concat("/").concat(String.new(FILE_PATH)).concat(slot).concat(String.new(EXTENSION_PATH))
      begin
        log = JSON.parse(File.read(path))
        log2= dump_load(log)
        @referee.update_board(log2)
        true
      rescue
        @ui.error_message("It was impossible to load the match.")
        false
      end
    end

    # Return true if match could be saved
    def save_match
      slot = @ui.ask_for_slot(true).to_s
      log = @referee.get_true_log
      path = String.new(DIR_PATH).concat("/").concat(String.new(FILE_PATH)).concat(slot).concat(String.new(EXTENSION_PATH))
      json = JSON.generate(log)
      begin
        f = File.new(path, 'w')
        f.write(json)
        f.close
        @referee.already_moved = false
        true
      rescue
        @ui.error_message("It was impossible to save the match.")
        false
      end
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
        save_match if @referee.already_moved && @ui.yes_no("Do you want to save the match before leaving")
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

    #ReturnS true if want a new game (or could not load the match properly)
    #RetrunS false if want to load a game
    def initial_options
      puts
      @ui.message("LET'S PLAY A NEW MATCH OF CHESS!")
      #Uncomment this when you want to implement the threefold or fivefold rules
      #@referee.threefold = @ui.yes_no("Do you want to active the threefold an fivefold repetition draw rules (that could make the game a bit more slower)")

      if read_slots.length > 0 && @ui.yes_no("Do you want to load a game")
        !load_match #If match is not correcly loaded, it starts a new match
      else
        true
      end
      
        #CHOOSE 1 OR 2 PLAYERS (WHEN IMPLEMENT AI)
    end

    def between_matches_options
      @referee.print_log if @ui.yes_no("Do you want to see the final log")
      save_match if @referee.already_moved && @ui.yes_no("Do you want to have the match saved")
      @quitting = !@ui.yes_no("Do you want to play another match")
    end

    private 

    def dump_load(log)
      log2 =[]
      log.each do |entry|
        movement = Hash.new
        if !entry["end"].nil?
          movement[:end] = entry["end"]
        else
          movement[:col1] = entry["col1"]
          movement[:row1] = entry["row1"]
          movement[:col2] = entry["col2"]
          movement[:row2] = entry["row2"]
          movement[:promotion] = entry["promotion"] if !entry["promotion"].nil?
        end
        log2.push(movement) 
      end
      log2
    end

  end
end