require_relative "piece"
require_relative "pawn"
require_relative "knight"
require_relative "bishop"
require_relative "rook"
require_relative "queen"
require_relative "king"
require "colorize"

module Chess
  class Board
    #UNICODE_BASE = "\u256"

    def initialize()
      clear_board
      clear_log
    end

    def clear_board
      @squares = Array.new(8) {Array.new(8)}
    end

    def clear_log
      @log  = []
    end

    def new_match
      clear_log
      clear_board
      initial_position
      @player = 0 
      @movement = 1
    end

    def initial_position
      #Setting pawns
      (0..7).each do |col|
        @squares[col][1] = Chess::Pawn.new(0,col+1,2)
        @squares[col][6] = Chess::Pawn.new(1,col+1,7)
      end
      #Setting figures
        @squares[0][0] = Chess::Rook.new(0,1,1)
        @squares[7][0] = Chess::Rook.new(0,8,1)
        @squares[0][7] = Chess::Rook.new(1,1,8)
        @squares[7][7] = Chess::Rook.new(1,8,8)
        @squares[1][0] = Chess::Knight.new(0,2,1)
        @squares[6][0] = Chess::Knight.new(0,7,1)
        @squares[1][7] = Chess::Knight.new(1,2,8)
        @squares[6][7] = Chess::Knight.new(1,7,8)
        @squares[2][0] = Chess::Bishop.new(0,3,1)
        @squares[5][0] = Chess::Bishop.new(0,6,1)
        @squares[2][7] = Chess::Bishop.new(1,3,8)
        @squares[5][7] = Chess::Bishop.new(1,6,8)
        @squares[3][0] = Chess::Queen.new(0,4,1)
        @squares[3][7] = Chess::Queen.new(1,4,8)
        @squares[4][0] = Chess::King.new(0,4,1)
        @squares[4][7] = Chess::King.new(1,4,8)
    end

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

    private

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