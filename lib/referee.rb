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

      #1 Player is in check_mate, stalemate, another draw situation or check?
      # Other draw situations:
      # Insufficient material
      # 75 rule
      # Fivefold rule
      stalemate = is_stalemate?(@board.player_turn) #We don't use #is_checkmate? method, in order not to call #is_stalemate? twice
                                              #which is a 4-nested loop
      in_check = is_king_in_check?(@board.player_turn)
      if stalemate && in_check
        check_mate
        return false
      elsif stalemate
        manage_draw(1)
        return false
      elsif draw_for_lack_of_power? #Insufficient material
        manage_draw(2)
        return false
      elsif in_check
        @ui.check_message
      end
      
      #2 Show number of movement
      @ui.message("Movement number #{(@movement / 2) + 1}:")

      #3 Remove all en_passant situations of the player
      remove_all_en_passants(@board.player_turn)

      #4 Ask for a movement, analize it and implement it if possible
      movement = @ui.ask_for_movement
      return false if movement == 0 #resign, offer/claim draw, quit
      case analize_movement(movement, in_check)
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
        #Legal Castling
        @board.get_piece(5,movement[:row1]).forbid_castling
        @board.change_position(5,movement[:row1],movement[:col2],movement[:row2])
        col1 = (movement[:col2] == 7 ? 8 : 1)
        col2 = (movement[:col2] == 7 ? 6 : 4)
        @board.get_piece(col1,movement[:row1]).forbid_castling
        @board.change_position(col1,movement[:row1],col2,movement[:row2])
        @movement += 1
        @board.switch_turn
        #TODO: IMPLEMENTA REGISTRO 

      when 3
        #Legal Capture en passant
        @previous_order = lambda {@ui.message("Pawn captured en passant.")}
        @board.change_position(movement[:col1],movement[:row1],movement[:col2],movement[:row2])
        @board.remove_piece(movement[:col2], movement[:row1])
        @movement += 1
        @board.switch_turn
        #TODO: IMPLEMENTA REGISTRO 
        
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
      when -10
        @previous_order = lambda {@ui.error_message("You can not castle while being in check.")}
      when -11
        @previous_order = lambda {@ui.error_message("You can not castle because your King has moved already.")}
      when -12
        @previous_order = lambda {@ui.error_message("You can not castle because the rook has moved already.")}
      when -13
        @previous_order = lambda {@ui.error_message("You can not castle because the way to castle is not free.")}
      when -14
        @previous_order = lambda {@ui.error_message("You can not castle bacause your King would have to pass through a check.")}
      when -15
        @previous_order = lambda {@ui.error_message("You can not castle because you would leave your king in check.")}
      when -16
        @previous_order = lambda {@ui.error_message("You can not castle twice.")}
      when -20 
        @previous_order = lambda {@ui.error_message("You can only capture en passant if the adjacent pawn has moved two squares in the previous turn.")}
      end

      true #This means that the match continues
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
      case modality
      when 1
        @ui.stalemate_message
      when 2
        @ui.warn_message ("None of the players have enought material to reach a checkmate.")
      end
      @ui.warn_message("Nobody wins. It's a draw.")
    end

    def check_mate
      #TODO IMPLEMENT
      @ui.mate_message
    end

    # Movement must be a hash parsed by the ui#parse_input, like this
    #{col1: 4, row1: 2, col2: 4, row2: 4}
    #Returns this code:
    # 1 = Legal movement (normal)
    # 2 = Legal movement (castling)
    # 3 = Legal movement (capture en_passant)
    # 0 = Ilegal movement (square1 empty)
    # -1 = Ilegal movement (square1 ocuppied by enemy piece)
    # -2 = Ilegal movement (square2 ocuppied by allied piece)
    # -3 = Ilegal movement (piece can not move to square2 - general)
    # -4 = Ilegal movement (leaves the king in check)
    # -5 = Ilegal movement (same square)
    # -10 to -16 = Ilegal castlings 
    # -20 = Ilegal en passant
    def analize_movement(movement, in_check)
      c1 = movement[:col1]
      r1 = movement[:row1]
      c2 = movement[:col2]
      r2 = movement[:row2]

      return analize_en_passant(movement) if intends_to_capture_en_passant?(movement)
      return analize_castling(movement, in_check) if intends_to_castle?(movement)
      return -5 if c1==c2 && r1==r2
      piece = @board.get_piece(c1, r1)
      return 0 if piece.nil?
      return -1 if piece.color!=@board.player_turn
      objetive = @board.get_piece(c2, r2)
      return -2 if !objetive.nil? && objetive.color == @board.player_turn
      return -3 if !piece.can_move?(c2,r2, @board)
      return -4 if leaves_king_in_check?(piece, objetive, c1, r1, c2, r2)

      #Correct normal movement
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

    #TESTED
    def intends_to_capture_en_passant?(movement)
      return false if (movement[:col1]-movement[:col2]).abs != 1
      my_pawn = @board.get_piece(movement[:col1], movement[:row1])
      return false if !my_pawn.is_a?(Chess::Pawn) || my_pawn.color != @board.player_turn
      if @board.player_turn ==0 #Player White
        return false if movement[:row1] != 5 || movement[:row2] != 6
        objective = @board.get_piece(movement[:col2], 5)
        return objective.is_a?(Chess::Pawn) && objective.color == 1
      else #Player Black
        return false if movement[:row1] != 4 || movement[:row2] != 3
        objective = @board.get_piece(movement[:col2], 4)
        return objective.is_a?(Chess::Pawn) && objective.color == 0
      end
    end

    #TESTED
    # return = 3 if legal capture
    # return = -20 if ilegal capture
    def analize_en_passant(movement) 
      pawn = @board.get_piece(movement[:col2], movement[:row1])
      pawn.status == 2 ? 3 : -20
    end

    #TESTED
    def remove_all_en_passants(color)
      (1..8).each do|y|
        (1..8).each do |x|
          piece = @board.get_piece(y,x)
          piece.remove_en_passant if piece.is_a?(Chess::Pawn) && piece.color == color
        end
      end
    end


    #TESTED
    def intends_to_castle?(movement)
      return true if movement[:castle] == true # Castle explicitly declared
      return false if movement[:col1] != 5
      return false if movement[:col2] != 3 && movement[:col2] != 7
      if @board.player_turn == 0 #Player White
        return false if movement[:row1] != 1 || movement[:row2] != 1
        figure = @board.get_piece(5,1)
        return false if !figure.is_a?(Chess::King) || figure.color != 0
        return true #Implicit castling
      else #Player Black
        return false if movement[:row1] != 8 || movement[:row2] != 8
        figure = @board.get_piece(5,8) 
        return false if !figure.is_a?(Chess::King) || figure.color != 1
        return true #Implicit castling
      end
    end

    #TESTED 
    def analize_castling(movement, in_check)
      return -16 if already_castled?
      return -10 if in_check
      row = (@board.player_turn == 0 ? 1 : 8)
      return -11 if king_moved?(row)
      return -12 if rook_moved?(movement[:col2],row)
      return -13 if blocked_way_to_castle?(movement[:col2],row)
      return -14 if castling_pass_through_check?(movement[:col2],row)
      return -15 if castling_leaves_in_check?(movement[:col2],row)  
      #Correct castling
      return 2
    end

    #TESTED 
    def already_castled?
      pos = find_king(@board.player_turn) 
      return @board.get_piece(pos[0], pos[1]).status == 2
    end

    #TESTED 
    def king_moved?(row)
      king = @board.get_piece(5,row)
      return !king.is_a?(Chess::King) || king.color != @board.player_turn || king.status > 0
    end

    #TESTED 
    def rook_moved?(col, row)
      col = (col == 7 ? 8 : 1)
      rook = @board.get_piece(col,row)
      return !rook.is_a?(Chess::Rook) || rook.color != @board.player_turn || rook.status > 0
    end

    #TESTED 
    def blocked_way_to_castle?(col, row)
      if col == 7 #Short castling
        return !(@board.get_piece(6, row).nil? && @board.get_piece(7, row).nil?)
      else #long castling
        return !(@board.get_piece(2, row).nil? && @board.get_piece(3, row).nil? && @board.get_piece(4, row).nil?)
      end
    end

    #TESTED 
    def castling_pass_through_check?(col,row)
      king = @board.get_piece(5,row)
      c2 = (col == 7 ? 6 : 4)
      leaves_king_in_check?(king, nil, 5, row, c2, row)
    end

    #TESTED 
    def castling_leaves_in_check?(col,row)
      king = @board.get_piece(5,row)
      leaves_king_in_check?(king, nil, 5, row, col, row)
    end

    #TESTED
    def pawn_promotion(col, player)
      row = (player == 0 ? 8 : 1)
      election = @ui.ask_for_promotion
      @board.spawn_new_piece(election, player, col, row)
      @board.get_piece(col, row).forbid_castling if election == 'R'
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