#Abstract class which the Chess Pieces Inherit

module Chess
  class Piece
    ORD_CONSTANT = 96

    attr_reader :color, :row, :col

    def initialize(color, col, row)
      raise TypeError.new "#{self.class} color is #{color}, when must be 0 (white) or 1 (black)" if color != 0 && color !=1
      situate_directly(col, row)
      @color = color
    end

    def col_letter
      return -1 if @col == -1
      (@col + ORD_CONSTANT).chr
    end

    def can_move?(col, row, board)
      raise NotImplementedError.new "#{self.class} has not implemented method can_move?"
    end

    def move(col, row, board)
      raise NotImplementedError.new "#{self.class} has not implemented method move"
    end

    def can_capture?(col, row, board)
      can_move?(col, row, board)
    end

    def situate_directly(col, row)
      filter_square(col, row)
      @col = col
      @row = row
    end

    def get_kind
      raise NotImplementedError.new "#{self.class} has not implemented method get_kind"
    end

    protected 

    def filter_square(col, row)
      raise TypeError.new "#{self.class} row is #{row}, when must be an Integer" if !row.is_a?(Integer)
      raise TypeError.new "#{self.class} col is #{col}, when must be an Integer" if !col.is_a?(Integer)
      raise TypeError.new "#{self.class} row is #{row}, when must be between 1 and 8" if !row.between?(1,8)
      raise TypeError.new "#{self.class} col is #{col}, when must be between 1 and 8" if !col.between?(1,8)
    end

    #Returns true when the square is empty
    #False if the square has a piece of the same color
    #"e" if the square has an enemy piece
    def free_square?(col, row, board)
      return false if @col == col && @row == row
      square = board.get_piece(col, row)
      return true if square.nil? 
      return "e" if square.color != @color
      false
    end

  end
end