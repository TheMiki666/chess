require_relative "board"
require_relative "piece"

module Chess
  class Pawn < Chess::Piece
    attr_reader :status

    def initialize(color, col, row)
      super(color, col, row)
      @status = 0 #0 = not moved yet, 1 = already moved, 2 = en_passant
    end

    def get_kind
      'P'
    end

    def remove_en_passant
        @status = 1 if @status == 2
    end

    def can_move?(col, row, board)
      filter_square(col, row)
      return false if col == @col && row == @row  #Same square
      if col == @col # Advance pawn
        can_advance?(col, row, board)
      elsif (col - @col ).abs == 1 # Adjacent cols => capturing
        can_do_a_capture?(col, row, board)
      else
        return false
      end
    end

    def move(col, row, board)
      return if !can_move?(col, row, board)
      @status = 1 
      @status = 2 if color == 0 and @row == 2 && row == 4
      @status = 2 if color == 1 and @row == 7 && row == 5
      board.change_position(@col, @row, col, row)
      #TODO: implement en_passant capture in here?
    end

    #This method is just used in method Board#analize_check
    #Overrides Piece#capture
    #Doesn't need the board (doen't mind if the are other pieces)
    def can_capture?(col, row, board=nil)
      filter_square(col, row)
      return false if (col - @col).abs != 1
      if @color == 0
        return row == @row + 1 
      else #@color == 1
        return row == @row - 1 
      end
    end

    private

    def can_advance?(col, row, board)
      if @color == 0
        if row == @row + 1
          return (free_square?(col, row, board) == true && free_square?(col, row, board) != 'e')
        elsif @row == 2 && row == 4
          a = free_square?(col, 4, board)
          b = free_square?(col, 3, board)
          return a == true && a != 'e' && b == true && b != 'e'
        else
          false
        end
      else #@color ==1
        if row == @row - 1
          return (free_square?(col, row, board) == true && free_square?(col, row, board) != 'e')
        elsif @row == 7 && row == 5
          a = free_square?(col, 5, board)
          b = free_square?(col, 6, board)
          return a == true && a != 'e' && b == true && b != 'e'
        else
          false
        end
      end
    end

    def can_do_a_capture?(col, row, board)
      if @color == 0 
        if row == @row + 1
          if free_square?(col, row, board) == 'e'
            true
          elsif @row == 5 && free_square?(col, row, board) == true
            #Possible capture en_passant
            can_capture_en_passant?(col, 5, board)
          else
            false
          end
        else
          false
        end
      else #@color == 1
        if row == @row - 1
          if free_square?(col, row, board) == 'e'
            true
          elsif @row == 4 && free_square?(col, row, board) == true 
            #Possible capture en_passant
            can_capture_en_passant?(col, 4, board)
          else
            false
          end
        else
          false
        end
      end
    end

    def can_capture_en_passant?(col, row, board)
      enemy = board.get_piece(col, row)
      if enemy.is_a?(Pawn) && enemy.color != @color && enemy.status == 2
        true #en passant
      else
        false
      end
    end

  end
end