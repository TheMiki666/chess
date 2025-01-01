require_relative "board"

module Chess
  class UserInterface
    ORD_CONSTANT = 96

    def initialize(board, game_manager)
      @board = board
      @game_manager = game_manager
    end
    
    #TESTED
    #Translates the player input to a movement
    #Returns a has with 2 squares: {[:col1],[:row1],[:col2],[:row2]}
    #Returns nil if the input has no sense
    def parse_input(string)
      string = string.downcase.strip.chomp
      if string == "o-o"
        castling('s') #short
      elsif string == "o-o-o"
        castling('l') #long
      else
        string = string[0..4] if string.length == 6 && string[5]=="+" #remove the check symbol
        return nil if string.length != 5
        extract_movement(string)
      end
    end

    private
    #TESTED
    def extract_movement(string)
      col1 = string[0].ord - ORD_CONSTANT
      row1 = string[1].to_i
      col2 = string[3].ord - ORD_CONSTANT
      row2 = string[4].to_i
      return nil if !row1.is_a?(Integer) || !row2.is_a?(Integer)
      return nil if !col1.between?(1,8) || !col2.between?(1,8) || !row1.between?(1,8) || !row2.between?(1,8)
      {col1: col1, row1: row1, col2: col2, row2: row2}
    end
    #TESTED
    def castling (mode)
      if @board.player_turn == 0
        king = @board.get_piece(5,1)
        if king.is_a?(Chess::King) && king.color == 0
          if mode == 's'
            {col1: 5, row1: 1, col2: 7, row2: 1}
          else #'l'
            {col1: 5, row1: 1, col2: 3, row2: 1}
          end
        else
          nil
        end
      else #board.player_turn == 1
        king = @board.get_piece(5,8)
        if king.is_a?(Chess::King) && king.color == 1
          if mode == 's'
            {col1: 5, row1: 8, col2: 7, row2: 8}
          else #'l'
            {col1: 5, row1: 8, col2: 3, row2: 8}
          end
        else
          nil
        end

      end
    end
  end
end