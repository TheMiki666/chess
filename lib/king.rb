require_relative "board"
require_relative "piece"

module Chess
  class King < Chess::Piece
    attr_reader :status, :check

    def initialize(color, col, row)
      super(color, col, row)
      @status = 0 #0 = not moved yet, 1 = already moved
      @check = false
    end

    def get_kind
      'K'
    end

    def can_move?(col, row, board)
      filter_square(col, row)
      return false if col == @col && row == @row  #Same square

      if (@col == 5 && (col == 7 || col == 3))
        can_castle?(col, row, board)
      elsif (col - @col).abs > 1 || (row - @row).abs > 1
        false
      else
        free_square?(col, row, board) == true || free_square?(col, row, board) == 'e'
      end
    end

    def move(col, row, board)
      return if !can_move?(col, row, board)
      @status = 1 
      board.change_position(@col, @row, col, row)
    end

    def can_castle?(col, row, board)
      #TODO IMPLEMENT CASTLING
      false
    end
  end
end