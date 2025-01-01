require_relative "../lib/board"
require_relative "../lib/pawn"

describe Chess::Pawn do
  describe "white Pawn#can_move? on an empty board from line 2 " do
    board = Chess::Board.new
    board.spawn_new_piece('p', 0, 6, 2)
    pawn = board.get_piece(6, 2)
    it "Can advance 1 square" do
      expect(pawn.can_move?(6, 3, board)).to be(true)
    end
    it "Can advance 2 squares" do
      expect(pawn.can_move?(6, 4, board)).to be(true)
    end
    it "Can't capture right" do
      expect(pawn.can_move?(7, 3, board)).to be(false)
    end
    it "Can't capture left" do
      expect(pawn.can_move?(5, 3, board)).to be(false)
    end
    it "Can't go back" do
      expect(pawn.can_move?(6, 1, board)).to be(false)
    end
    it "Can't change column" do
      expect(pawn.can_move?(5, 2, board)).to be(false)
    end
    it "Can't stay in the same place" do
      expect(pawn.can_move?(6, 2, board)).to be(false)
    end
    it "Can't advance 3 squares" do
      expect(pawn.can_move?(6, 5, board)).to be(false)
    end
    it "Can't move randomly" do
      expect(pawn.can_move?(1, 1, board)).to be(false)
    end
    it "Rises a error when moving('PQ',3)" do
      expect{pawn.can_move?('PQ', 3, board)}.to raise_error(TypeError)
    end
  end

  describe "black Pawn#can_move? on an empty board from line 7 " do
    board = Chess::Board.new
    board.spawn_new_piece('p', 1, 6, 7)
    pawn = board.get_piece(6, 7)
    it "Can advance 1 square" do
      expect(pawn.can_move?(6, 6, board)).to be(true)
    end
    it "Can advance 2 squares" do
      expect(pawn.can_move?(6, 5, board)).to be(true)
    end
    it "Can't capture right" do
      expect(pawn.can_move?(7, 6, board)).to be(false)
    end
    it "Can't capture left" do
      expect(pawn.can_move?(5, 6, board)).to be(false)
    end
    it "Can't go back" do
      expect(pawn.can_move?(6, 8, board)).to be(false)
    end
    it "Can't change column" do
      expect(pawn.can_move?(5, 7, board)).to be(false)
    end
    it "Can't stay in the same place" do
      expect(pawn.can_move?(6, 7, board)).to be(false)
    end
    it "Can't advance 3 squares" do
      expect(pawn.can_move?(6, 4, board)).to be(false)
    end
    it "Can't move randomly" do
      expect(pawn.can_move?(1, 1, board)).to be(false)
    end
    it "Rises a error when moving('PQ',3)" do
      expect{pawn.can_move?('PQ', 3, board)}.to raise_error(TypeError)
    end
  end

  describe "white Pawn#can_move? on an empty board from line 3 " do
    board = Chess::Board.new
    board.spawn_new_piece('p', 0, 6, 3)
    pawn = board.get_piece(6, 3)
    it "Can advance 1 square" do
      expect(pawn.can_move?(6, 4, board)).to be(true)
    end
    it "Can't advance 2 squares" do
      expect(pawn.can_move?(6, 5, board)).to be(false)
    end
  end

  describe "black Pawn#can_move? on an empty board from line 6 " do
    board = Chess::Board.new
    board.spawn_new_piece('p', 1, 6, 6)
    pawn = board.get_piece(6, 6)
    it "Can advance 1 square" do
      expect(pawn.can_move?(6, 5, board)).to be(true)
    end
    it "Can't advance 2 squares" do
      expect(pawn.can_move?(6, 4, board)).to be(false)
    end
  end

  describe "white Pawn#can_move? on with enemies from line 2 " do
    board = Chess::Board.new
    board.spawn_new_piece('p', 0, 6, 2)
    pawn = board.get_piece(6, 2)
    board.spawn_new_piece('r', 1, 5, 3)
    board.spawn_new_piece('r', 1, 6, 3)
    board.spawn_new_piece('r', 1, 7, 3)
    board.spawn_new_piece('r', 1, 5, 1)
    board.spawn_new_piece('r', 1, 6, 1)
    board.spawn_new_piece('r', 1, 7, 1)
    board.spawn_new_piece('r', 1, 5, 2)
    board.spawn_new_piece('r', 1, 7, 2)
    it "Can't advance 1 square" do
      expect(pawn.can_move?(6, 3, board)).to be(false)
    end
    it "Can't advance 2 squares" do
      expect(pawn.can_move?(6, 4, board)).to be(false)
    end
    it "Can capture right" do
      expect(pawn.can_move?(7, 3, board)).to be(true)
    end
    it "Can capture left" do
      expect(pawn.can_move?(5, 3, board)).to be(true)
    end
    it "Can't move backward" do
      expect(pawn.can_move?(6, 1, board)).to be(false)
    end
    it "Can't capture right backward" do
      expect(pawn.can_move?(7, 1, board)).to be(false)
    end
    it "Can't capture left backward" do
      expect(pawn.can_move?(5, 1, board)).to be(false)
    end
    it "Can't capture right side" do
      expect(pawn.can_move?(7, 2, board)).to be(false)
    end
    it "Can't capture left side" do
      expect(pawn.can_move?(5, 2, board)).to be(false)
    end
  end

  describe "white Pawn#can_move? on with allies from line 2 " do
    board = Chess::Board.new
    board.spawn_new_piece('p', 0, 6, 2)
    pawn = board.get_piece(6, 2)
    board.spawn_new_piece('r', 0, 5, 3)
    board.spawn_new_piece('r', 0, 6, 3)
    board.spawn_new_piece('r', 0, 7, 3)
    board.spawn_new_piece('r', 0, 5, 1)
    board.spawn_new_piece('r', 0, 6, 1)
    board.spawn_new_piece('r', 0, 7, 1)
    board.spawn_new_piece('r', 0, 5, 2)
    board.spawn_new_piece('r', 0, 7, 2)
    it "Can't advance 1 square" do
      expect(pawn.can_move?(6, 3, board)).to be(false)
    end
    it "Can't advance 2 squares" do
      expect(pawn.can_move?(6, 4, board)).to be(false)
    end
    it "Can't capture right" do
      expect(pawn.can_move?(7, 3, board)).to be(false)
    end
    it "Can't capture left" do
      expect(pawn.can_move?(5, 3, board)).to be(false)
    end
    it "Can't move backward" do
      expect(pawn.can_move?(6, 1, board)).to be(false)
    end
    it "Can't capture right backward" do
      expect(pawn.can_move?(7, 1, board)).to be(false)
    end
    it "Can't capture left backward" do
      expect(pawn.can_move?(5, 1, board)).to be(false)
    end
    it "Can't capture right side" do
      expect(pawn.can_move?(7, 2, board)).to be(false)
    end
    it "Can't capture left side" do
      expect(pawn.can_move?(5, 2, board)).to be(false)
    end
  end

  describe "black Pawn#can_move? on with enemies from line 7 " do
    board = Chess::Board.new
    board.spawn_new_piece('p', 1, 6, 7)
    pawn = board.get_piece(6, 7)
    board.spawn_new_piece('r', 0, 5, 6)
    board.spawn_new_piece('r', 0, 6, 6)
    board.spawn_new_piece('r', 0, 7, 6)
    board.spawn_new_piece('r', 0, 5, 8)
    board.spawn_new_piece('r', 0, 6, 8)
    board.spawn_new_piece('r', 0, 7, 8)
    board.spawn_new_piece('r', 0, 5, 7)
    board.spawn_new_piece('r', 0, 7, 7)
    it "Can't advance 1 square" do
      expect(pawn.can_move?(6, 6, board)).to be(false)
    end
    it "Can't advance 2 squares" do
      expect(pawn.can_move?(6, 5, board)).to be(false)
    end
    it "Can capture right" do
      expect(pawn.can_move?(7, 6, board)).to be(true)
    end
    it "Can capture left" do
      expect(pawn.can_move?(5, 6, board)).to be(true)
    end
    it "Can't move backward" do
      expect(pawn.can_move?(6, 8, board)).to be(false)
    end
    it "Can't capture right backward" do
      expect(pawn.can_move?(7, 8, board)).to be(false)
    end
    it "Can't capture left backward" do
      expect(pawn.can_move?(5, 8, board)).to be(false)
    end
    it "Can't capture right side" do
      expect(pawn.can_move?(7, 7, board)).to be(false)
    end
    it "Can't capture left side" do
      expect(pawn.can_move?(5, 7, board)).to be(false)
    end
  end

  describe "black Pawn#can_move? on with allies from line 7 " do
    board = Chess::Board.new
    board.spawn_new_piece('p', 1, 6, 7)
    pawn = board.get_piece(6, 7)
    board.spawn_new_piece('r', 1, 5, 6)
    board.spawn_new_piece('r', 1, 6, 6)
    board.spawn_new_piece('r', 1, 7, 6)
    board.spawn_new_piece('r', 1, 5, 8)
    board.spawn_new_piece('r', 1, 6, 8)
    board.spawn_new_piece('r', 1, 7, 8)
    board.spawn_new_piece('r', 1, 5, 7)
    board.spawn_new_piece('r', 1, 7, 7)
    it "Can't advance 1 square" do
      expect(pawn.can_move?(6, 6, board)).to be(false)
    end
    it "Can't advance 2 squares" do
      expect(pawn.can_move?(6, 5, board)).to be(false)
    end
    it "Can't capture right" do
      expect(pawn.can_move?(7, 6, board)).to be(false)
    end
    it "Can't capture left" do
      expect(pawn.can_move?(5, 6, board)).to be(false)
    end
    it "Can't move backward" do
      expect(pawn.can_move?(6, 8, board)).to be(false)
    end
    it "Can't capture right backward" do
      expect(pawn.can_move?(7, 8, board)).to be(false)
    end
    it "Can't capture left backward" do
      expect(pawn.can_move?(5, 8, board)).to be(false)
    end
    it "Can't capture right side" do
      expect(pawn.can_move?(7, 7, board)).to be(false)
    end
    it "Can't capture left side" do
      expect(pawn.can_move?(5, 7, board)).to be(false)
    end
  end

  describe "white Pawn#can_move? on with enemies from line 6 " do
    board = Chess::Board.new
    board.spawn_new_piece('p', 0, 6, 6)
    pawn = board.get_piece(6, 6)
    board.spawn_new_piece('r', 1, 5, 7)
    board.spawn_new_piece('r', 1, 7, 7)
    it "Can capture right" do
      expect(pawn.can_move?(7, 7, board)).to be(true)
    end
    it "Can capture left" do
      expect(pawn.can_move?(5, 7, board)).to be(true)
    end
  end

  describe "white Pawn#can_move? on with enemies from line 3 " do
    board = Chess::Board.new
    board.spawn_new_piece('p', 1, 6, 3)
    pawn = board.get_piece(6, 3)
    board.spawn_new_piece('r', 0, 5, 2)
    board.spawn_new_piece('r', 0, 7, 2)
    it "Can capture right" do
      expect(pawn.can_move?(5, 2, board)).to be(true)
    end
    it "Can capture left" do
      expect(pawn.can_move?(7, 2, board)).to be(true)
    end
  end

  describe "Testing Pawn#can capture?" do
    board = Chess::Board.new
    board.spawn_new_piece('p', 1, 6, 3)
    pawn_b= board.get_piece(6, 3)
    board.spawn_new_piece('p', 0, 2, 5)
    pawn_w= board.get_piece(2, 5)
    it "White pawn could capture on (1, 6)" do
      expect(pawn_w.can_capture?(1, 6)).to be(true)
    end
    it "White pawn could capture on (3, 6)" do
      expect(pawn_w.can_capture?(3, 6)).to be(true)
    end
    it "Black pawn could capture on (5, 2)" do
      expect(pawn_b.can_capture?(5, 2)).to be(true)
    end
    it "Black pawn could capture on (3, 2)" do
      expect(pawn_b.can_capture?(7, 2)).to be(true)
    end
    it "Black pawn could not capture on (6, 2)" do
      expect(pawn_b.can_capture?(6, 2)).to be(false)
    end
    it "Black pawn could not capture on (2, 6)" do
      expect(pawn_w.can_capture?(2, 6)).to be(false)
    end
  end
end