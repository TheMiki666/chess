require_relative "board"
require_relative "piece"

module Chess
  class Rook < Chess::Piece
    attr_reader :status

    def initialize(color, col, row)
      super(color, col, row)
      @status = 0 #0 = not moved yet, 1 = already moved
    end

    def can_move?(col, row, board)
      filter_square(col, row)
      return false if col == @col && row == @row  #Same square
      return false if col != @col && row != @row  #Not same row and not same col
      can_move = true
      if col > @col #moves right
        (@col + 1 .. col).each do |y|       
          square = board.get_piece(y, row)   
          if !square.nil?
            if square.color == color # There is a piece of the same color in the way
              can_move = false
            elsif y != col # There is a enemy piece in the way, but it is not the last square
              can_move = false
            end
            break
          end
        end
      elsif col < @col #moves left
        y = @col - 1
        while y >= col    
          square = board.get_piece(y, row)   
          if !square.nil?
            if square.color == color # There is a piece of the same color in the way
              can_move = false
            elsif y != col # There is a enemy piece in the way, but it is not the last square
              can_move = false
            end
            break
          end
          y -= 1
        end
      elsif row > @row #moves up
        (@row + 1 .. row).each do |x|       
          square =  board.get_piece(col, x)   
          if !square.nil?
            if square.color == color # There is a piece of the same color in the way
              can_move = false
            elsif x != row # There is a enemy piece in the way, but it is not the last square
              can_move = false
            end
            break
          end
        end
      else # row < @row #moves down
        x = @row - 1
        while x >= row    
          square = board.get_piece(col, x)   
          if !square.nil?
            if square.color == color # There is a piece of the same color in the way
              can_move = false
            elsif x != row # There is a enemy piece in the way, but it is not the last square
              can_move = false
            end
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
      #TODO do movement
    end

  end
end