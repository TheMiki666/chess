require_relative "piece"
require_relative "pawn"
require_relative "knight"
require_relative "bishop"
require_relative "rook"
require_relative "queen"
require_relative "king"

module Chess
  class Board

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
      (1..8).each do |col|
        @squares[col][2] = Chess:Pawn.new(0,0)
      end
    end

  end
end