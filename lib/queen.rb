require_relative "board"
require_relative "piece"

module Chess
  class Queen < Chess::Piece
    
    def get_kind
      'Q'
    end

    def can_move?(col, row, board)
      filter_square(col, row)
      return false if col == @col && row == @row  #Same square
      return false if (col - @col).abs != (row - @row).abs && col != @col && row != @row
      
      can_move = true
      if row == @row && col > @col #moves right
        (@col + 1 .. col).each do |y|       
          if !free_square?(y, row, board) || (free_square?(y, row, board) == "e" && y != col)
            can_move = false
            break
          end
        end
      elsif row == @row && col < @col #moves left
        y = @col - 1
        while y >= col      
          if !free_square?(y, row, board) || (free_square?(y, row, board) == "e" && y != col)
            can_move = false
            break
          end
          y -= 1
        end
      elsif col == @col && row > @row #moves up
        (@row + 1 .. row).each do |x|         
          if !free_square?(col, x, board) || (free_square?(col, x, board) == "e" && x != row)
            can_move = false
            break
          end
        end
      elsif col == @col && row < @row #moves down
        x = @row - 1
        while x >= row    
          if !free_square?(col, x, board) || (free_square?(col, x, board) == "e" && x != row)
            can_move = false
            break
          end
          x -= 1
        end
      elsif col > @col && row > @row #up-right diagonal
        (1..col - @col).each do |i|
          if !free_square?(@col + i, @row + i, board) || (free_square?(@col + i, @row + i, board) == "e" && @col + i != col)
            can_move = false
            break
          end
        end 
      elsif col < @col && row > @row #up-left diagonal
        (1..@col - col).each do |i|
          if !free_square?(@col - i, @row + i, board) || (free_square?(@col - i, @row + i, board) == "e" && @col - i != col)
            can_move = false
            break
          end
        end
      elsif col > @col && row < @row #down-right diagonal
        (1..col - @col).each do |i|
          if !free_square?(@col + i, @row - i, board) || (free_square?(@col + i, @row - i, board) == "e" && @col + i != col)
            can_move = false
            break
          end
        end
      else # col < @col && row < @row #down-left diagonal
        (1..@col - col).each do |i|
          if !free_square?(@col - i, @row - i, board) || (free_square?(@col - i, @row - i, board) == "e" && @col - i != col)
            can_move = false
            break
          end
        end
      end
      can_move
    end

    def move(col, row, board)
      return if !can_move?(col, row, board)
      board.change_position(@col, @row, col, row)
    end

  end
end