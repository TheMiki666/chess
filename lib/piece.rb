#Abstract class which the Chess Pieces Inherit
module Chess
  class Piece
    ORD_CONSTANT = 96

    attr_reader :color, :row

    def initialize(color, square)
      raise TypeError.new "#{self.class} color is #{color}, when must be 0 (white) or 1 (black)" if color != 0 && color !=1
      situate_directly(square)
      @color = color
    end

    def col
      return -1 if @col == -1
      (@col + ORD_CONSTANT).chr
    end

    def col_num
      @col
    end


    def be_captured
      @row = -1
      @col = -1
    end

    def can_move?(square)
      raise NotImplementedError.new "#{self.class} has not implemented method can_move?"
    end

    def move(square)
      raise NotImplementedError.new "#{self.class} has not implemented method move"
    end

    def situate_directly(square)
      my_square = filter_square(square)
      @col = my_square[0]
      @row = my_square[1]
    end

    private 

    def filter_square(square)
      error = false
      if !square.is_a?(String) || square.length != 2 
        error = true
      else
        col = square[0].downcase
        row = square[1].to_i
        if !row.is_a?(Integer) || row < 1 || row > 8 || col < 'a' || col > 'h'
          error = true
        else
          return [col.ord - ORD_CONSTANT, row]
        end
      end
      raise TypeError.new "#{self.class} square is #{square}, when must be 'a1' to 'h8'" if error
    end
  end
end