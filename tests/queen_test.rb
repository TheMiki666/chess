require_relative "../lib/board"
require_relative "../lib/queen"

describe Chess::Queen do
  describe "#can_move? on an empty board" do
    board = Chess::Board.new
    board.spawn_new_piece('Q', 1, 4, 4)
    queen = board.get_piece(4, 4)

    (5..8).each do |x|
      it "Can move horizontally to (#{x},4)" do
        expect(queen.can_move?(x, 4, board)).to be(true)
      end
    end
    (1..3).each do |x|
      it "Can move horizontally to (#{x},4)" do
        expect(queen.can_move?(x, 4, board)).to be(true)
      end
    end
    (5..8).each do |y|
      it "Can move vertically to (4,#{y})" do
        expect(queen.can_move?(4, y, board)).to be(true)
      end
    end
    (1..3).each do |y|
      it "Can move vertically to (4,#{y})" do
        expect(queen.can_move?(4, y, board)).to be(true)
      end
    end
    (5..8).each do |x|
      it "Can move diagonally to (#{x},#{x})" do
        expect(queen.can_move?(x, x, board)).to be(true)
      end
    end
    (1..3).each do |x|
      it "Can move diagonally to (#{x},#{x})" do
        expect(queen.can_move?(x, x, board)).to be(true)
      end
    end
    (1..3).each do |x|
      it "Can move diagonally to (#{4 + x},#{4 - x})" do
        expect(queen.can_move?(4 + x, 4 - x, board)).to be(true)
      end
    end
    (1..3).each do |x|
      it "Can move diagonally to (#{4 - x},#{4 + x})" do
        expect(queen.can_move?(4 - x, 4 + x, board)).to be(true)
      end
    end
    it "Can't move to the same square" do
      expect(queen.can_move?(4, 4, board)).to be(false)
    end
    it "Can't move like a knight" do
      expect(queen.can_move?(5, 6, board)).to be(false)
    end
    it "Can't move randomly" do
      expect(queen.can_move?(1, 2, board)).to be(false)
    end
    it "Rises an error when moving(0,3)" do
      expect{queen.can_move?(0,3, board)}.to raise_error(TypeError)
    end
  end

  describe "#can_move? on an board with other pieces" do
    board = Chess::Board.new
    board.spawn_new_piece('Q', 1, 4, 4)
    queen = board.get_piece(4, 4)
    board.spawn_new_piece('Q', 0, 2, 4)
    board.spawn_new_piece('R', 0, 6, 4)
    board.spawn_new_piece('K', 1, 2, 2)
    board.spawn_new_piece('P', 1, 2, 6)
    it "Can capture an enemy piece" do
      expect(queen.can_move?(2, 4, board)).to be(true)
    end
    it "Can't capture an allied piece" do
      expect(queen.can_move?(2, 2, board)).to be(false)
    end
    it "Can't pass through another piece" do
      expect(queen.can_move?(8, 4, board)).to be(false)
    end
    it "Can move stopping before another piece" do
      expect(queen.can_move?(3, 5, board)).to be(true)
    end

  end
end