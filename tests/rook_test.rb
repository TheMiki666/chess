require_relative "../lib/board"
require_relative "../lib/rook"

describe Chess::Rook do
  describe "#can_move? on an empty board" do
    board = Chess::Board.new
    board.spawn_new_piece('R', 0, 4, 4)
    rook = board.get_piece(4, 4)
    (5..8).each do |x|
      it "Can move horizontally to (#{x},4)" do
        expect(rook.can_move?(x, 4, board)).to be(true)
      end
    end
    (1..3).each do |x|
      it "Can move horizontally to (#{x},4)" do
        expect(rook.can_move?(x, 4, board)).to be(true)
      end
    end
    (5..8).each do |y|
      it "Can move vertically to (4,#{y})" do
        expect(rook.can_move?(4, y, board)).to be(true)
      end
    end
    (1..3).each do |y|
      it "Can move vertically to (4,#{y})" do
        expect(rook.can_move?(4, y, board)).to be(true)
      end
    end
    it "Can't to the same square" do
      expect(rook.can_move?(4, 4, board)).to be(false)
    end
    it "Can't move out of the row and the column (1,1)" do
      expect(rook.can_move?(1, 1, board)).to be(false)
    end
    it "Can't move out of the row and the column (7,7)" do
      expect(rook.can_move?(1, 1, board)).to be(false)
    end
    it "Can't move out of the row and the column (6,2)" do
      expect(rook.can_move?(1, 1, board)).to be(false)
    end
    it "Can't move out of the row and the column (2,6)" do
      expect(rook.can_move?(1, 1, board)).to be(false)
    end
  end

  describe "#can_move? on a board with obstacles of the same team" do
    board = Chess::Board.new
    board.spawn_new_piece('R', 0, 4, 4)
    board.spawn_new_piece('B', 0, 7, 4) #White Bishop at right
    board.spawn_new_piece('Q', 0, 2, 4) #White Queen at left
    board.spawn_new_piece('K', 0, 4, 8) #White King up
    board.spawn_new_piece('P', 0, 4, 3) #White Pawn down

    rook = board.get_piece(4, 4)
    (5..6).each do |x|
      it "Can move horizontally to (#{x},4)" do
        expect(rook.can_move?(x, 4, board)).to be(true)
      end
    end
    (7..8).each do |x|
      it "Can't pass obstacle horizontally to (#{x},4)" do
        expect(rook.can_move?(x, 4, board)).to be(false)
      end
    end
    (1..2).each do |x|
      it "Can't pass obstacle horizontally to (#{x},4)" do
        expect(rook.can_move?(x, 4, board)).to be(false)
      end
    end
    it "Can move horizontally to (3,4)" do
      expect(rook.can_move?(3, 4, board)).to be(true)
    end
    (5..7).each do |y|
      it "Can move vertically to (4,#{y})" do
        expect(rook.can_move?(4, y, board)).to be(true)
      end
    end
    it "Can't pass obstacle vertically to (4,8)" do
      expect(rook.can_move?(4, 8, board)).to be(false)
    end
    (1..3).each do |y|
      it "Can't pass obstacle vertically to (4,#{y})" do
        expect(rook.can_move?(4, y, board)).to be(false)
      end
    end
  end

  describe "#can_move? on a board with obstacles of the enemy team" do
    board = Chess::Board.new
    board.spawn_new_piece('R', 1, 4, 4)
    board.spawn_new_piece('B', 0, 7, 4) #White Bishop at right
    board.spawn_new_piece('Q', 0, 2, 4) #White Queen at left
    board.spawn_new_piece('K', 0, 4, 8) #White King up
    board.spawn_new_piece('P', 0, 4, 3) #White Pawn down
    rook = board.get_piece(4, 4)
    (5..7).each do |x|
      it "Can move horizontally to (#{x},4)" do
        expect(rook.can_move?(x, 4, board)).to be(true)
      end
    end
    (8..8).each do |x|
      it "Can't pass obstacle horizontally to (#{x},4)" do
        expect(rook.can_move?(x, 4, board)).to be(false)
      end
    end
    (1..1).each do |x|
      it "Can't pass obstacle horizontally to (#{x},4)" do
        expect(rook.can_move?(x, 4, board)).to be(false)
      end
    end
    (2..3).each do |x|
      it "Can move horizontally to (#{x},4)" do
        expect(rook.can_move?(x, 4, board)).to be(true)
      end
    end
    (5..8).each do |y|
      it "Can move vertically to (4,#{y})" do
        expect(rook.can_move?(4, y, board)).to be(true)
      end
    end
    (1..2).each do |y|
      it "Can't pass obstacle vertically to (4,#{y})" do
        expect(rook.can_move?(4, y, board)).to be(false)
      end
    end
    it "Can move vertically to (4,3)" do
      expect(rook.can_move?(4, 3, board)).to be(true)
    end
  end

  describe "#can_move? raise errors when the square is not correct" do
    board = Chess::Board.new
    board.spawn_new_piece('R', 1, 4, 4)
    rook = board.get_piece(4, 4)
    it "Error when moving(4,-1)" do
      expect{rook.can_move?(4, -1, board)}.to raise_error(TypeError)
    end
    it "Error when moving(4,nil)" do
      expect{rook.can_move?(4, nil, board)}.to raise_error(TypeError)
    end
    it "Error when moving('c0w',8)" do
      expect{rook.can_move?('c0w', 8, board)}.to raise_error(TypeError)
    end
    it "Error when moving(9,8)" do
      expect{rook.can_move?(9, 8, board)}.to raise_error(TypeError)
    end
  end
end