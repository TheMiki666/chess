require_relative "board"
require_relative "piece"

module Chess
  class King < Chess::Piece
    attr_reader :status

    def initialize(color, col, row)
      super(color, col, row)
      @status = 0 #0 = not moved yet, 1 = already moved, 2 = already castled
    end

    def get_kind
      'K'
    end

    #Use this method after castling 
    def forbid_castling
      @status = 2
    end

    def can_move?(col, row, board)
      filter_square(col, row)
      return false if col == @col && row == @row  #Same square

      #Castling is not implemented in here, because it can not be use to scape from a check,
      #neither to capture a piece
      if (col - @col).abs > 1 || (row - @row).abs > 1
        false
      else
        free_square?(col, row, board) == true || free_square?(col, row, board) == 'e'
      end
    end

    def move(col, row, board)
      return if !can_move?(col, row, board)
      @status = 1 if @status == 0
      board.change_position(@col, @row, col, row)
    end

  end
end