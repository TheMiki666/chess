require_relative('board')
require_relative('user_interface')

module Chess
  # This class is complementary to board
  # It takes the user input, analices it, and declares valid or not valid
  # It also analizes if a player is in check, in check mate or in stalemate
  # It also analizes if there is another kind of draw (e.g., king vs king and bishop)
  # It also analizes the special rules of chess: pawn capture en passant, pawn promotion and castling
  # It also controles the log
  class Referee
    COUNT_TO_DRAW = 100
    
    def initialize(board, user_interface)
      @board = board
      @ui = user_interface
      clear_log
      @board.clear_board
    end

    def new_match
      clear_log
      @board.new_match
      @movement = 0
      @movements_to_draw = COUNT_TO_DRAW
    end

    def clear_log
      @log  = []
    end

    # Movement must be a hash parsed by the ui#parse_input, like this
    #{col1: 4, row1: 2, col2: 4, row2: 4}
    #Returns this code:
    # 1 = Legal movement (normal)
    # 2 = Legal movement (short castling)
    # 3 = Legal movement (long castling)
    # 4 = Legal movement (capture en_passant)
    # 5 = Legal movement (pawn promotion)
    # 0 = Ilegal movement (square1 empty)
    # -1 = Ilegal movement (square1 ocuppied by enemy piece)
    # -2 = Ilegal movement (square2 ocuppied by allied piece)
    # -3 = Ilegal movement (piece can not move to square2 - general)
    # -4 = Ilegal movement (leaves the king in check)
    # -5 = Ilegal movement (castling with moved king)
    # -6 = Ilegal movement (castling with moved rook)
    # -7 = Ilegal movement (castling without free squares)
    # -8 = Ilegal movement (castling from, to or passing by a check position)
    # -9 = Ilegal movement (forbidden en_passant capture)
    def analize_movement(movement)
      c1 = movement[:col1]
      r1 = movement[:row1]
      c2 = movement[:col2]
      r2 = movement[:row2]

      piece = @board.get_piece(c1, r1)
      return 0 if piece.nil?
      return -1 if piece.color!=@board.player_turn
      objetive = @board.get_piece(c2, r2)
      return -2 if !objetive.nil? && objetive.color == @board.player_turn
      return -3 if !piece.can_move?(c2,r2, @board)
      return -4 if leaves_king_in_check?(piece, objetive, c1, r1, c2, r2)
      #All is correct!
      return 1
    end

    # TESTED
    # Checks if any move the player does, leaves his king in check 
    # MAYBE CAN BE REFACTORED
    def is_stalemate?(color)
      (1..8).each do |c1|
        (1..8).each do |r1|
          piece = @board.get_piece(c1,r1)
          if !piece.nil? && piece.color == color
            (1..8).each do |c2|
              (1..8).each do |r2|
                if piece.can_move?(c2, r2, @board)
                  objetive = @board.get_piece(c2,r2)
                  return false if !leaves_king_in_check?(piece, objetive, c1, r1, c2, r2)
                end
              end
            end
          end
        end
      end
      true
    end

    def is_check_mate?(color)
      is_king_in_check?(color) && is_stalemate?(color)
    end

    #TESTED
    def lack_of_power?(color)
      army = count_pieces(color)
      return false if army['Q'] > 0 || army['R'] > 0 || army['P'] > 0
      return false if army['N'] > 1
      return false if army['N'] == 1 && army ['B'] > 0
      return false if army['BinW'] > 0 && army['BinB'] > 0
      true
    end

    def count_pieces(color)
      counter = {}
      counter['K'] = 0
      counter['Q'] = 0
      counter['R'] = 0
      counter['B'] = 0
      counter['N'] = 0
      counter['P'] = 0
      counter['BinW'] = 0
      counter['BinB'] = 0
      # BinW = Bishop in white squares, BinW = Bishop in black squares, 
      (1..8).each do |c|
        (1..8).each do |r|
          piece = @board.get_piece(c, r)
          if !piece.nil? && piece.color == color
            counter[piece.get_kind] += 1
            if piece.get_kind == 'B'
              if (c+r)%2 == 1 #white square
                counter['BinW'] += 1
              else #black square
                counter['BinB'] += 1
              end
            end
          end
        end
      end
      counter
    end

    #TESTED
    def is_king_in_check?(color)
      king_position = find_king(color)
      @board.analize_check(king_position[0], king_position[1], color==0?1:0)
    end

    private 

    #TESTED
    def leaves_king_in_check?(piece, objetive, c1, r1, c2, r2)
      #We use copycat of the original piece to move it
      copycat = @board.spawn_new_piece(piece.get_kind, piece.color, c1, r1)
      @board.change_position(c1, r1, c2, r2)
      check = is_king_in_check?(@board.player_turn)
      #Now we place back the pieces to the original positions and forget the copycat
      @board.set_piece(c1, r1, piece)
      @board.set_piece(c2, r2, objetive)
      check
    end

    def find_king(color)
      (1..8).each do|y|
        (1..8).each do |x|
          return [y,x] if @board.get_piece(y,x).is_a?(Chess::King) && @board.get_piece(y,x).color == color
        end
      end
    end
  end
end