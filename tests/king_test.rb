require_relative "../lib/board"
require_relative "../lib/king"

describe Chess::King do
  describe "#can_move? on an empty board" do
    board = Chess::Board.new
    board.spawn_new_piece('K', 0, 3, 3)
    king = board.get_piece(3, 3)
    it "Can move to (3,4)" do
      expect(king.can_move?(3, 4, board)).to be(true)
    end
    it "Can move to (4,3)" do
      expect(king.can_move?(4, 3, board)).to be(true)
    end
    it "Can move to (3,2)" do
      expect(king.can_move?(3, 2, board)).to be(true)
    end
    it "Can move to (2,3)" do
      expect(king.can_move?(2, 3, board)).to be(true)
    end
    it "Can move to (4,4)" do
      expect(king.can_move?(4, 4, board)).to be(true)
    end
    it "Can move to (2,4)" do
      expect(king.can_move?(2, 4, board)).to be(true)
    end
    it "Can move to (4,2)" do
      expect(king.can_move?(4, 2, board)).to be(true)
    end
    it "Can move to (2,2)" do
      expect(king.can_move?(2, 2, board)).to be(true)
    end
    it "Can't move to the same square" do
      expect(king.can_move?(3, 3, board)).to be(false)
    end
    it "Can't move two squares" do
      expect(king.can_move?(5, 3, board)).to be(false)
    end
    it "Can't move as a rook" do
      expect(king.can_move?(3, 8, board)).to be(false)
    end
    it "Can't move randomly" do
      expect(king.can_move?(7, 8, board)).to be(false)
    end
    it "Rises an error when moving(-3,4)" do
      expect{king.can_move?(-3, 4, board)}.to raise_error(TypeError)
    end
  end
  describe "#can_move? trying to castle on its own" do
    board = Chess::Board.new
    board.spawn_new_piece('K', 0, 5, 1)
    king = board.get_piece(5, 1)
    it "Can't do short castling" do
      expect(king.can_move?(7, 1, board)).to be(false)
    end
    it "Can't do long castling" do
      expect(king.can_move?(3, 1, board)).to be(false)
    end
  end

  describe "#can_move? surrounded by enemies" do
    board = Chess::Board.new
    board.spawn_new_piece('K', 1, 3, 3)
    king = board.get_piece(3, 3)
    board.spawn_new_piece('B', 0, 3, 4)
    board.spawn_new_piece('B', 0, 3, 2)
    board.spawn_new_piece('B', 0, 4, 3)
    board.spawn_new_piece('B', 0, 2, 3)
    board.spawn_new_piece('R', 0, 4, 4)
    board.spawn_new_piece('R', 0, 2, 2)
    board.spawn_new_piece('R', 0, 4, 2)
    board.spawn_new_piece('R', 0, 2, 4)
    it "Can move to (3,4)" do
      expect(king.can_move?(3, 4, board)).to be(true)
    end
    it "Can move to (4,3)" do
      expect(king.can_move?(4, 3, board)).to be(true)
    end
    it "Can move to (3,2)" do
      expect(king.can_move?(3, 2, board)).to be(true)
    end
    it "Can move to (2,3)" do
      expect(king.can_move?(2, 3, board)).to be(true)
    end
    it "Can move to (4,4)" do
      expect(king.can_move?(4, 4, board)).to be(true)
    end
    it "Can move to (2,4)" do
      expect(king.can_move?(2, 4, board)).to be(true)
    end
    it "Can move to (4,2)" do
      expect(king.can_move?(4, 2, board)).to be(true)
    end
    it "Can move to (2,2)" do
      expect(king.can_move?(2, 2, board)).to be(true)
    end
  end

  describe "#can_move? surrounded by allies" do
    board = Chess::Board.new
    board.spawn_new_piece('K', 0, 3, 3)
    king = board.get_piece(3, 3)
    board.spawn_new_piece('B', 0, 3, 4)
    board.spawn_new_piece('B', 0, 3, 2)
    board.spawn_new_piece('B', 0, 4, 3)
    board.spawn_new_piece('B', 0, 2, 3)
    board.spawn_new_piece('R', 0, 4, 4)
    board.spawn_new_piece('R', 0, 2, 2)
    board.spawn_new_piece('R', 0, 4, 2)
    board.spawn_new_piece('R', 0, 2, 4)
    it "Can't move to (3,4)" do
      expect(king.can_move?(3, 4, board)).to be(false)
    end
    it "Can't move to (4,3)" do
      expect(king.can_move?(4, 3, board)).to be(false)
    end
    it "Can't move to (3,2)" do
      expect(king.can_move?(3, 2, board)).to be(false)
    end
    it "Can't move to (2,3)" do
      expect(king.can_move?(2, 3, board)).to be(false)
    end
    it "Can't move to (4,4)" do
      expect(king.can_move?(4, 4, board)).to be(false)
    end
    it "Can't move to (2,4)" do
      expect(king.can_move?(2, 4, board)).to be(false)
    end
    it "Can't move to (4,2)" do
      expect(king.can_move?(4, 2, board)).to be(false)
    end
    it "Can't move to (2,2)" do
     expect(king.can_move?(2, 2, board)).to be(false)
    end
  end
end