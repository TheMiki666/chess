require_relative "board"
require_relative "piece"

module Chess
  class Bishop < Chess::Piece

    def get_kind
      'B'
    end

    def can_move?(col, row, board)
      filter_square(col, row)
      return false if col == @col && row == @row  #Same square
      return false if (col - @col).abs != (row - @row).abs #Not diagonal move
      can_move = true
        if col > @col && row > @row
          (1..col - @col).each do |i|
            if !free_square?(@col + i, @row + i, board) || (free_square?(@col + i, @row + i, board) == "e" && @col + i != col)
              can_move = false
              break
            end
          end
          
        elsif col < @col && row > @row
          (1..@col - col).each do |i|
            if !free_square?(@col - i, @row + i, board) || (free_square?(@col - i, @row + i, board) == "e" && @col - i != col)
              can_move = false
              break
            end
          end

        elsif col > @col && row < @row
          (1..col - @col).each do |i|
            if !free_square?(@col + i, @row - i, board) || (free_square?(@col + i, @row - i, board) == "e" && @col + i != col)
              can_move = false
              break
            end
          end

        else # col < @col && row < @row
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