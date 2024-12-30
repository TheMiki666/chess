require_relative "board"
require_relative "piece"

module Chess
  class Knight < Chess::Piece

    def can_move?(col, row, board)
      filter_square(col, row)
      return false if !(((@col - col).abs == 2 && (@row - row).abs == 1) || ((@col - col).abs == 1 && (@row - row).abs == 2))
      return false if !(free_square?(col, row, board)) 
      true
    end

    def move(col, row, board)
      return if !can_move?(col, row, board)
      board.change_position(@col, @row, col, row)
    end
  end
end