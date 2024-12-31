require_relative "../lib/board"
require_relative "../lib/bishop"

describe Chess::Bishop do
  describe "#can_move? on an empty board" do
    board = Chess::Board.new
    board.spawn_new_piece('B', 0, 4, 4)
    bishop = board.get_piece(4, 4)
    (5..8).each do |x|
      it "Can move to (#{x},#{x})" do
        expect(bishop.can_move?(x, x, board)).to be(true)
      end
    end
    (1..3).each do |x|
      it "Can move to (#{x},#{x})" do
        expect(bishop.can_move?(x, x, board)).to be(true)
      end
    end
    (1..3).each do |x|
      it "Can move to (#{4 + x},#{4 - x})" do
        expect(bishop.can_move?(4 + x, 4 - x, board)).to be(true)
      end
    end
    (1..3).each do |x|
      it "Can move to (#{4 - x},#{4 + x})" do
        expect(bishop.can_move?(4 - x, 4 + x, board)).to be(true)
      end
    end
    it "Can't move to the same square" do
      expect(bishop.can_move?(4, 4, board)).to be(false)
    end
    it "Can't move horizontally" do
      expect(bishop.can_move?(7, 4, board)).to be(false)
    end
    it "Can't move vertically" do
      expect(bishop.can_move?(4, 7, board)).to be(false)
    end
    it "Can't move like a knight" do
      expect(bishop.can_move?(5, 6, board)).to be(false)
    end
    it "Can't move randomly" do
      expect(bishop.can_move?(1, 2, board)).to be(false)
    end
    it "Rise an error when moving('c',3)" do
      expect{bishop.can_move?('c',3, board)}.to raise_error(TypeError)
    end
  end

  describe "#can_move? on another diagonal" do
    board = Chess::Board.new
    board.spawn_new_piece('B', 0, 1, 4)
    bishop = board.get_piece(1, 4)
    (1..4).each do |x|
      it "Can move to (#{1 + x},#{4 + x})" do
        expect(bishop.can_move?(1 + x, 4 + x, board)).to be(true)
      end
    end
    (1..3).each do |x|
      it "Can move to (#{1 + x},#{4 - x})" do
        expect(bishop.can_move?(1 + x, 4 - x, board)).to be(true)
      end
    end
    (1..7).each do |x|
      it "Can't move to the main diagonal (#{x},#{x})" do
        expect(bishop.can_move?(x, x, board)).to be(false)
      end
    end
  end

  describe "#can_move? with obstacles" do
    board = Chess::Board.new
    board.spawn_new_piece('B', 0, 4, 4)
    bishop = board.get_piece(4, 4)
    board.spawn_new_piece('R', 1, 7, 7)
    board.spawn_new_piece('N', 0, 2, 2)
    board.spawn_new_piece('P', 1, 2, 6)
    board.spawn_new_piece('Q', 0, 6, 2)
    it "Can't pass through the obstacle (7,7)" do
      expect(bishop.can_move?(8, 8, board)).to be(false)
    end
    it "Can't pass through the obstacle (2,2)" do
      expect(bishop.can_move?(1, 1, board)).to be(false)
      end
    it "Can't pass through the obstacle (2,6)" do
      expect(bishop.can_move?(1, 7, board)).to be(false)
    end
    it "Can't pass through the obstacle (6,2)" do
      expect(bishop.can_move?(7, 1, board)).to be(false)
    end
    it "Can move stopping before the obstacle (7,7)" do
      expect(bishop.can_move?(6, 6, board)).to be(true)
    end
    it "Can move stopping before the obstacle (2,2)" do
      expect(bishop.can_move?(3, 3, board)).to be(true)
    end
    it "Can move stopping before the obstacle (2,6)" do
      expect(bishop.can_move?(3, 5, board)).to be(true)
    end
    it "Can move stopping before the obstacle (6,2)" do
      expect(bishop.can_move?(5, 3, board)).to be(true)
    end
    it "Can't capture an allied piece (2,2)" do
      expect(bishop.can_move?(2, 2, board)).to be(false)
    end
    it "Can't capture an allied piece (6,2)"do
      expect(bishop.can_move?(6, 2, board)).to be(false)
    end
    it "Can capture an enemy piece (7,7)" do
      expect(bishop.can_move?(7, 7, board)).to be(true)
    end
    it "Can capture an enemy piece (2,6)"do
      expect(bishop.can_move?(2, 6, board)).to be(true)
    end
  end
end