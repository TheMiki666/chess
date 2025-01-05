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
    MANDATORY_DAW = -50
    THREEFOLD_REPETITION = 3
    FIVEFOLD_REPETITION = 5
    ORD_CONSTANT = 96
    
    def initialize(board, user_interface)
      @board = board
      @ui = user_interface
      clear_log
      @board.clear_board
      @previous_order = nil
    end

    def new_match
      clear_log
      @board.new_match
      @movement = 0
      @movements_to_draw = COUNT_TO_DRAW
      @previous_order = nil
    end

    def clear_log
      @log  = []
    end

    #TODO: maybe this loop must be managed by game manager
    def game_loop
      loop do
        continue = turn_process
        break if !continue
      end
    end

    # This is the series of steps the Referee has to do each turn
    # Return true if the match continues, false if it finishes
    def turn_process
      @board.draw_board

      if !@previous_order.nil?
        @previous_order.call
        @previous_order = nil
      end

      #1 Player is in check_mate, stale_mate or check?
      stalemate = is_stalemate?(@board.player_turn) #We don't use #is_checkmate? method, in order not to call #is_stalemate? twice
                                              #which is a 4-nested loop
      in_check = is_king_in_check?(@board.player_turn)
      @ui.message("Movement number #{(@movement / 2) + 1}:") if !stalemate
      if stalemate && in_check
        check_mate
        return false
      elsif stalemate
        manage_draw(1)
        return false
      elsif in_check
        @ui.check_message
      end

      #2 Analyice other draw situations
      # Insufficient material
      # 75 rule
      # Fivefold rule
  
      #3 Remove all en_passant situations of the player
      remove_all_en_passants(@board.player_turn)

      #4 Ask for a movement, analize it and implement it if possible
      movement = @ui.ask_for_movement
      return false if movement == 0 #resign, offer/claim draw, quit
      case analize_movement(movement)
      when 1
        #Normal legal movement
        piece = @board.get_piece(movement[:col1],movement[:row1])
        piece.move(movement[:col2],movement[:row2], @board)
        #TODO: IMPLEMENTA REGISTRO (TIENES QUE VER SI ES UNA CAPTURA O NO)
        #TODO: SI MUEVE UN PEÓN O CAPTURA, RESETEA EL CONTADOR MOVES TO DRAW
        #TODO: ANALIZA EL THREEFOLD Y FIVEFOLD
        if piece.is_a?(Chess::Pawn) 
          if (movement[:row2] == 8 && @board.player_turn == 0) || (movement[:row2] == 1 && @board.player_turn == 1)
            pawn_promotion(movement[:col2],@board.player_turn)
          end
        end
        @movement += 1
        @board.switch_turn

      when 2
        #Short castling

      when 3
        #Long castling

      when 4
        #capture en passant

      when 5
        #pawn promotion
      
      when -5
        @previous_order = lambda {@ui.error_message("Both squares are the same: #{write_square(movement[:col1],movement[:row1])}.")}
      when 0
        @previous_order = lambda {@ui.error_message("First square #{write_square(movement[:col1],movement[:row1])} is empty.")}
      when -1
        @previous_order = lambda {@ui.error_message("First square #{write_square(movement[:col1],movement[:row1])} is occupied by an enemy piece.")}
      when -2
        @previous_order = lambda {@ui.error_message("Second square #{write_square(movement[:col2],movement[:row2])} is occupied by a piece of yours.")}
      when -3
        @previous_order = lambda {@ui.error_message("Your piece can not do that movement.")}
      when -4
        if in_check
          @previous_order = lambda {@ui.error_message("That movement does not release you from the check.")}
        else
          @previous_order = lambda {@ui.error_message("That movement would leave you in check.")}
        end
      end

      true
    end

    # 1 = Stalemate
    # 2 = Insufficient material (lack of power)
    # 3 = Mutual agreement
    # 4 = 50 turns rule
    # 5 = 75 turns rule
    # 6 = Threefold
    # 7 = Fivefold
    def manage_draw(modality)
      #TODO IMPLEMENT
      @ui.warn_message("DRAW")
    end

    def check_mate
      #TODO IMPLEMENT
      @ui.mate_message
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
    # -5 = Ilegal movement (same square)
    def analize_movement(movement)
      c1 = movement[:col1]
      r1 = movement[:row1]
      c2 = movement[:col2]
      r2 = movement[:row2]

      return -5 if c1==c2 && r1==r2
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

    # only used in tests, not in the #turn_process
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

    def draw_for_lack_of_power?
      #Most frecuent situation
      return false if !lack_of_power?(0) || !lack_of_power?(1)

      #If one of the teams has a knight and the other has a knight or bishop, it's not draw
      army1 = count_pieces(0)
      army2 = count_pieces(1)
      return false if army1['N'] > 0 && (army2['N'] > 0 || army2['B'] > 0)
      return false if army2['N'] > 0 && (army1['N'] > 0 || army1['B'] > 0)

      #Just bishops to analize
      return true if army1['total'] == 1 && army2['total'] == 1  #Just both kings
      #If both teams have just one bishop and both bishops are of the same color, it's a draw
      if army1['BinB'] > 0 && army2['BinW'] > 0
        false
      elsif army1['BinW'] > 0 && army2['BinB'] > 0
        false
      else
        true
      end
    end

    #TESTED
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
      counter['total'] = 0
      # BinW = Bishop in white squares, BinW = Bishop in black squares, 
      (1..8).each do |c|
        (1..8).each do |r|
          piece = @board.get_piece(c, r)
          if !piece.nil? && piece.color == color
            counter[piece.get_kind] += 1
            counter['total'] += 1
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

    def pawn_promotion(col, player)
      row = (player == 0 ? 8 : 1)
      election = @ui.ask_for_promotion
      @board.spawn_new_piece(election, player, col, row)
      @board.get_piece(col, row).forbid_castling if election == 'R'
    end

    def remove_all_en_passants(color)
      (1..8).each do|y|
        (1..8).each do |x|
          piece = @board.get_piece(y,x)
          piece.remove_en_passant if piece.is_a?(Chess::Pawn) && piece.color == color
        end
      end
    end

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

    def write_square(col, row)
      "(#{(col + ORD_CONSTANT).chr}#{row})"
    end
  end
end