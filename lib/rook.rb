require_relative "board"
require_relative "piece"

module Chess
  class Rook < Chess::Piece
    attr_reader :status

    def initialize(color, col, row)
      super(color, col, row)
      @status = 0 #0 = not moved yet, 1 = already moved
    end

    def get_kind
      'R'
    end

    #Use this method after castling or when spawning a new rook from pawn promotion
    def forbid_castling
      @status = 1
    end

    def can_move?(col, row, board)
      filter_square(col, row)
      return false if col == @col && row == @row  #Same square
      return false if col != @col && row != @row  #Not same row and not same col
      can_move = true
      if col > @col #moves right
        (@col + 1 .. col).each do |y|       
          if !free_square?(y, row, board) || (free_square?(y, row, board) == "e" && y != col)
            can_move = false
            break
          end
        end
      elsif col < @col #moves left
        y = @col - 1
        while y >= col      
          if !free_square?(y, row, board) || (free_square?(y, row, board) == "e" && y != col)
            can_move = false
            break
          end
          y -= 1
        end
      elsif row > @row #moves up
        (@row + 1 .. row).each do |x|         
          if !free_square?(col, x, board) || (free_square?(col, x, board) == "e" && x != row)
            can_move = false
            break
          end
        end
      else # row < @row #moves down
        x = @row - 1
        while x >= row    
          if !free_square?(col, x, board) || (free_square?(col, x, board) == "e" && x != row)
            can_move = false
            break
          end
          x -= 1
        end
      end
      can_move
    end

    def move(col, row, board)
      return if !can_move?(col, row, board)
      @status = 1 
      board.change_position(@col, @row, col, row)
    end

  end
end