require_relative "piece"
require_relative "pawn"
require_relative "knight"
require_relative "bishop"
require_relative "rook"
require_relative "queen"
require_relative "king"
require "colorize"

module Chess
  #Is the object that contains the pieces
  #It also controls the player turn and the number of movement (not the counter to draw)
  #It also controls the TRUE LOG (the true series movements made before)
  #It is the object which is going to be serialized when saving or loading the match
  class Board
    attr_reader :squares, :player_turn

    def initialize()
      clear_board
      clear_log
    end

    def clear_board
      @squares = Array.new(8) {Array.new(8)}
    end

    def clear_log
      @true_log  = []
    end

    def new_match
      clear_log
      clear_board
      initial_position
      @player_turn = 0 
      @movement = 1
    end

    #TESTED
    def switch_turn
      @player_turn = (@player_turn == 0 ? 1 : 0)
    end

    #TESTED
    def spawn_new_piece (piece, color, col, row)
      raise TypeError.new "#{self.class} piece is #{piece}, when must be 'K','Q','R','B','N' or 'P'"  if !piece.is_a?(String)
      piece = piece.upcase
      new_piece = nil
      case piece 
      when 'K'
        new_piece = Chess::King.new(color, col, row)
      when 'Q'
        new_piece = Chess::Queen.new(color, col, row)
      when 'R'
        new_piece = Chess::Rook.new(color, col, row)
      when 'B'
        new_piece = Chess::Bishop.new(color, col, row)
      when 'N'
        new_piece = Chess::Knight.new(color, col, row)
      when 'P'
        new_piece = Chess::Pawn.new(color, col, row)
      else
        raise TypeError.new "#{self.class} piece is #{piece}, when must be 'K','Q','R','B','N' or 'P'" 
      end  
      remove_piece(col, row)
      @squares[col-1][row-1] = new_piece    
    end

    #TESTED
    def remove_piece(col, row)
      raise TypeError.new "#{self.class} col is #{col}, when must be between 1-8" if !col.between?(1,8) 
      raise TypeError.new "#{self.class} row is #{row}, when must be between 1-8" if !row.between?(1,8) 
      @squares[col-1][row-1] = nil
    end

    #TESTED
    def change_position(col1, row1, col2, row2)
      raise TypeError.new "#{self.class} col1 is #{col1}, when must be between 1-8" if !col1.between?(1,8) 
      raise TypeError.new "#{self.class} row1 is #{row1}, when must be between 1-8" if !row1.between?(1,8) 
      raise TypeError.new "#{self.class} col2 is #{col2}, when must be between 1-8" if !col2.between?(1,8) 
      raise TypeError.new "#{self.class} row2 is #{row2}, when must be between 1-8" if !row2.between?(1,8) 
      return if @squares[col1-1][row1-1].nil?
      remove_piece(col2, row2)
      @squares[col1-1][row1-1].situate_directly(col2,row2)
      @squares[col2-1][row2-1] = @squares[col1-1][row1-1]
      @squares[col1-1][row1-1] = nil
    end

    #TESTED
    def get_piece(col, row)
      raise TypeError.new "#{self.class} col is #{col}, when must be between 1-8" if !col.between?(1,8) 
      raise TypeError.new "#{self.class} row is #{row}, when must be between 1-8" if !row.between?(1,8) 
      @squares[col-1][row-1]
    end

    #TESTED
    def set_piece(col, row, piece)
      raise TypeError.new "#{self.class} col is #{col}, when must be between 1-8" if !col.between?(1,8) 
      raise TypeError.new "#{self.class} row is #{row}, when must be between 1-8" if !row.between?(1,8) 
      @squares[col-1][row-1] = piece
    end

    #TESTED
    def initial_position
      #Setting pawns
      (1..8).each do |col|
        spawn_new_piece('P',0,col,2)
        spawn_new_piece('P',1,col,7)
      end
      #Setting figures
      spawn_new_piece('R',0,1,1)
      spawn_new_piece('R',0,8,1)
      spawn_new_piece('R',1,1,8)
      spawn_new_piece('R',1,8,8)
      spawn_new_piece('N',0,2,1)
      spawn_new_piece('N',0,7,1)
      spawn_new_piece('N',1,2,8)
      spawn_new_piece('N',1,7,8)
      spawn_new_piece('B',0,3,1)
      spawn_new_piece('B',0,6,1)
      spawn_new_piece('B',1,3,8)
      spawn_new_piece('B',1,6,8)
      spawn_new_piece('Q',0,4,1)
      spawn_new_piece('Q',1,4,8)
      spawn_new_piece('K',0,5,1)
      spawn_new_piece('K',1,5,8)
    end

    #TESTED
    def draw_board
      puts
      puts "  | a | b | c | d | e | f | g | h |  "
      puts "--+---+---+---+---+---+---+---+---+--"
      (1..8).each do |r| 
        row = 9 - r
        print row
        print " | "
        (1..8).each do |col|
          paint_piece(@squares[col-1][row-1])
          print " | "
        end
        puts row
        puts "--+---+---+---+---+---+---+---+---+--"
      end
      puts "  | a | b | c | d | e | f | g | h |  "
      puts
    end

    #TESTED
    #This method is just used in test, not in production code
    def visual_check_analysis(color)
      puts
      puts "  | a | b | c | d | e | f | g | h |  "
      puts "--+---+---+---+---+---+---+---+---+--"
      (1..8).each do |r| 
        row = 9 - r
        print row
        print " | "
        (1..8).each do |col|
          if analize_check(col, row, color) == true
            print "x".colorize(:red)
          else
            print " "
          end
          print " | "
        end
        puts row
        puts "--+---+---+---+---+---+---+---+---+--"
      end
      puts "  | a | b | c | d | e | f | g | h |  "
      puts
    end

    #TESTED 
    # Returns true if the square is menaced by any figure of the color
    def analize_check(col, row, color)
      #We must remove temporally the piece on the row and col to analize if it is in check
      piece = get_piece(col, row)
      remove_piece(col, row) if !piece.nil?
      check = analize_menace(col, row, color)
      set_piece(col, row, piece) #Return the piece to its position
      check
    end

    private
    def analize_menace(col, row, color)
      (1..8).each do |x|
        (1..8).each do |y|
          piece = get_piece(x,y)
          if !piece.nil? && piece.color == color && piece.can_capture?(col, row, self)
            return true
          end
        end
      end
      false
    end
      
    #TESTED
    def paint_piece(piece)
      if piece.nil? || !piece.is_a?(Chess::Piece)
        print " "
        return
      end
      if piece.color == 0
        if piece.is_a?(Chess::King)
          print "\u2654".colorize(:yellow)
        elsif piece.is_a?(Chess::Queen)
          print "\u2655".colorize(:yellow)
        elsif piece.is_a?(Chess::Rook)
          print "\u2656".colorize(:yellow)
        elsif piece.is_a?(Chess::Bishop)
          print "\u2657".colorize(:yellow)
        elsif piece.is_a?(Chess::Knight)
          print "\u2658".colorize(:yellow)
        elsif piece.is_a?(Chess::Pawn)
          print "\u2659".colorize(:yellow)          
        end
      elsif piece.color == 1
        if piece.is_a?(Chess::King)
          print "\u265A".colorize(:blue)
        elsif piece.is_a?(Chess::Queen)
          print "\u265B".colorize(:blue)
        elsif piece.is_a?(Chess::Rook)
          print "\u265C".colorize(:blue)
        elsif piece.is_a?(Chess::Bishop)
          print "\u265D".colorize(:blue)
        elsif piece.is_a?(Chess::Knight)
          print "\u265E".colorize(:blue)
        elsif piece.is_a?(Chess::Pawn)
          print "\u265F".colorize(:blue)          
        end
      end
    end

  end
end