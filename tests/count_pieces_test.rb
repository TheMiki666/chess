require_relative ('../lib/referee')

describe Chess::Referee do
  describe "#count_pieces in the initial position" do
    board = Chess::Board.new
    referee = Chess::Referee.new(board, nil)
    referee.new_match
    w_counter = referee.count_pieces(0)
    b_counter = referee.count_pieces(1)
    it "8 white pawns" do
      expect(w_counter['P']).to eq(8)
    end
    it "2 white knights" do
      expect(w_counter['N']).to eq(2)
    end
    it "2 white bishops" do
      expect(w_counter['B']).to eq(2)
    end
    it "2 white rooks" do
      expect(w_counter['R']).to eq(2)
    end
    it "1 white queen" do
      expect(w_counter['Q']).to eq(1)
    end
    it "1 white king" do
      expect(w_counter['K']).to eq(1)
    end
    it "1 white bishop on white squares" do
      expect(w_counter['BinW']).to eq(1)
    end
    it "1 white bishop on black squares" do
      expect(w_counter['BinW']).to eq(1)
    end
    it "8 black pawns" do
      expect(b_counter['P']).to eq(8)
    end
    it "2 black knights" do
      expect(b_counter['N']).to eq(2)
    end
    it "2 black bishops" do
      expect(b_counter['B']).to eq(2)
    end
    it "2 black rooks" do
      expect(b_counter['R']).to eq(2)
    end
    it "1 black queen" do
      expect(b_counter['Q']).to eq(1)
    end
    it "1 black king" do
      expect(b_counter['K']).to eq(1)
    end
    it "1 black bishop on white squares" do
      expect(b_counter['BinW']).to eq(1)
    end
    it "1 black bishop on black squares" do
      expect(b_counter['BinW']).to eq(1)
    end
  end

  describe "#count_pieces in the initial position" do
    board = Chess::Board.new
    referee = Chess::Referee.new(board, nil)
    referee.new_match
    board.clear_board
    board.spawn_new_piece('K', 0, 1, 1)
    board.spawn_new_piece('K', 1, 1, 8)
    board.spawn_new_piece('K', 0, 1, 1)
    board.spawn_new_piece('B', 0, 2, 1)
    board.spawn_new_piece('B', 0, 3, 1)
    board.spawn_new_piece('B', 0, 4, 1)
    board.spawn_new_piece('B', 0, 5, 1)    
    board.spawn_new_piece('B', 1, 1, 7)
    board.spawn_new_piece('B', 1, 1, 6)
    board.spawn_new_piece('B', 1, 1, 5)
    board.spawn_new_piece('B', 1, 1, 3)
    board.draw_board
    w_counter = referee.count_pieces(0)
    b_counter = referee.count_pieces(1)
    it "2 white bishops on white squares" do
      expect(w_counter['BinW']).to eq(2)
    end
    it "2 white bishops on black squares" do
      expect(w_counter['BinB']).to eq(2)
    end
    it "3 black bishop on black squares" do
      expect(b_counter['BinB']).to eq(3)
    end
    it "1 black bishop on white squares" do
      expect(b_counter['BinW']).to eq(1)
    end
    it "4 white bishops" do
      expect(w_counter['B']).to eq(4)
    end
    it "1 white king" do
      expect(w_counter['K']).to eq(1)
    end
    it "no white pawns" do
      expect(w_counter['P']).to eq(0)
    end
  end

  describe "#lack of power?" do
    describe "only with kings" do
      board = Chess::Board.new
      referee = Chess::Referee.new(board, nil)
      referee.new_match
      board.clear_board
      board.spawn_new_piece('K', 0, 5, 1)
      board.spawn_new_piece('K', 1, 5, 8)
      board.draw_board
      it "white can not win just with a king" do
        expect(referee.lack_of_power?(0)).to be(true)
      end
      it "black can not win just with a king" do
        expect(referee.lack_of_power?(1)).to be(true)
      end
    end
    describe "with powerful pieces" do
      board = Chess::Board.new
      referee = Chess::Referee.new(board, nil)
      referee.new_match
      board.clear_board
      board.spawn_new_piece('K', 0, 5, 1)
      board.spawn_new_piece('K', 1, 5, 8)
      board.spawn_new_piece('Q', 1, 4, 8)
      board.spawn_new_piece('R', 0, 1, 1)
      board.draw_board
      it "white can win with its rook" do
        expect(referee.lack_of_power?(0)).to be(false)
      end
      it "black can win with its queen" do
        expect(referee.lack_of_power?(1)).to be(false)
      end
    end
    describe "with a pawn" do
      board = Chess::Board.new
      referee = Chess::Referee.new(board, nil)
      referee.new_match
      board.clear_board
      board.spawn_new_piece('K', 0, 5, 1)
      board.spawn_new_piece('K', 1, 5, 8)
      board.spawn_new_piece('P', 1, 7, 7)
      board.draw_board
      it "black can win with a pawn" do
        expect(referee.lack_of_power?(1)).to be(false)
      end
      it "white can not win just with a king" do
        expect(referee.lack_of_power?(0)).to be(true)
      end
    end
    describe "with low power pieces" do
      board = Chess::Board.new
      referee = Chess::Referee.new(board, nil)
      referee.new_match
      board.clear_board
      board.spawn_new_piece('K', 0, 5, 1)
      board.spawn_new_piece('K', 1, 5, 8)
      board.spawn_new_piece('N', 1, 2, 8)
      board.spawn_new_piece('B', 0, 3, 2)
      board.draw_board
      it "black can not win with king and knight" do
        expect(referee.lack_of_power?(1)).to be(true)
      end
      it "white can not win with king and bishop" do
        expect(referee.lack_of_power?(0)).to be(true)
      end
    end
      describe "with bishops in the same color" do
      board = Chess::Board.new
      referee = Chess::Referee.new(board, nil)
      referee.new_match
      board.clear_board
      board.spawn_new_piece('K', 0, 5, 1)
      board.spawn_new_piece('K', 1, 5, 8)
      board.spawn_new_piece('B', 1, 1, 7)
      board.spawn_new_piece('B', 1, 3, 7)
      board.spawn_new_piece('B', 1, 5, 7)
      board.spawn_new_piece('B', 0, 1, 2)
      board.spawn_new_piece('B', 0, 3, 2)
      board.spawn_new_piece('B', 0, 5, 2)
      board.draw_board
      it "black has lack of power with all bishops on black squares" do
        expect(referee.lack_of_power?(1)).to be(true)
      end
      it "black has lack of power with all bishops on white squares" do
        expect(referee.lack_of_power?(0)).to be(true)
      end
    end
    describe "with bishops in different color" do
      board = Chess::Board.new
      referee = Chess::Referee.new(board, nil)
      referee.new_match
      board.clear_board
      board.spawn_new_piece('K', 0, 5, 1)
      board.spawn_new_piece('K', 1, 5, 8)
      board.spawn_new_piece('B', 1, 1, 7)
      board.spawn_new_piece('B', 1, 2, 7)
      board.draw_board
      it "black can win with a bishop in different color squares" do
        expect(referee.lack_of_power?(1)).to be(false)
      end
    end
  end
  describe "with two minor pieces" do
    board = Chess::Board.new
    referee = Chess::Referee.new(board, nil)
    referee.new_match
    board.clear_board
    board.spawn_new_piece('K', 0, 5, 1)
    board.spawn_new_piece('K', 1, 5, 8)
    board.spawn_new_piece('N', 1, 2, 8)
    board.spawn_new_piece('N', 1, 7, 8)
    board.spawn_new_piece('N', 0, 2, 1)
    board.spawn_new_piece('B', 0, 3, 1)
    board.draw_board
    it "black can win with two knights" do
      expect(referee.lack_of_power?(1)).to be(false)
    end
    it "white can win with a bishop and a knight" do
      expect(referee.lack_of_power?(0)).to be(false)
    end
  end
end