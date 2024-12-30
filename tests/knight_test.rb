require_relative "../lib/board"
require_relative "../lib/knight"

describe Chess::Knight do
  describe "#can_move? on an empty board" do
    board = Chess::Board.new
    board.spawn_new_piece('N', 1, 4, 4)
    knight = board.get_piece(4, 4)
    it "Can move to (5,6)" do
      expect(knight.can_move?(5, 6, board)).to be(true)
    end
    it "Can move to (5,2)" do
      expect(knight.can_move?(5, 2, board)).to be(true)
    end
    it "Can move to (3,6)" do
      expect(knight.can_move?(3, 6, board)).to be(true)
    end
    it "Can move to (3,2)" do
      expect(knight.can_move?(3, 2, board)).to be(true)
    end
    it "Can move to (6,3)" do
      expect(knight.can_move?(6, 3, board)).to be(true)
    end
    it "Can move to (6,5)" do
      expect(knight.can_move?(6, 5, board)).to be(true)
    end
    it "Can move to (2,3)" do
      expect(knight.can_move?(2, 3, board)).to be(true)
    end
    it "Can move to (2,5)" do
      expect(knight.can_move?(2, 5, board)).to be(true)
    end
    it "Can't move to the same square" do
      expect(knight.can_move?(4, 4, board)).to be(false)
    end
    it "Can't move to (4,5)" do
      expect(knight.can_move?(4, 5, board)).to be(false)
    end
    it "Can't move to (4,8)" do
      expect(knight.can_move?(4, 8, board)).to be(false)
    end
    it "Can't move to (1,1)" do
      expect(knight.can_move?(4, 5, board)).to be(false)
    end
    it "Can't move to (2,6)" do
      expect(knight.can_move?(2, 6, board)).to be(false)
    end
    it "Rises an error when moving(9,8)" do
      expect{knight.can_move?(9, 8, board)}.to raise_error(TypeError)
    end
  end

  describe "#can_move? on an board surrounded by enemies" do
    board = Chess::Board.new
    board.spawn_new_piece('N', 1, 4, 4)
    knight = board.get_piece(4, 4)
    board.spawn_new_piece('P', 0, 3, 6)
    board.spawn_new_piece('P', 0, 3, 2)
    board.spawn_new_piece('P', 0, 5, 6)
    board.spawn_new_piece('P', 0, 5, 2)
    board.spawn_new_piece('P', 0, 6, 5)
    board.spawn_new_piece('P', 0, 6, 3)
    board.spawn_new_piece('P', 0, 2, 5)
    board.spawn_new_piece('P', 0, 2, 3)
    it "Can move to (5,6)" do
      expect(knight.can_move?(3, 2, board)).to be(true)
    end
    it "Can move to (5,2)" do
      expect(knight.can_move?(5, 2, board)).to be(true)
    end
    it "Can move to (3,6)" do
      expect(knight.can_move?(3, 6, board)).to be(true)
    end
    it "Can move to (3,2)" do
      expect(knight.can_move?(3, 2, board)).to be(true)
    end
    it "Can move to (6,3)" do
      expect(knight.can_move?(6, 3, board)).to be(true)
    end
    it "Can move to (6,5)" do
      expect(knight.can_move?(6, 5, board)).to be(true)
    end
    it "Can move to (2,3)" do
      expect(knight.can_move?(2, 3, board)).to be(true)
    end
    it "Can move to (2,5)" do
      expect(knight.can_move?(2, 5, board)).to be(true)
    end
  end

  describe "#can_move? on an board surrounded by pieces of the same team" do
    board = Chess::Board.new
    board.spawn_new_piece('N', 0, 4, 4)
    knight = board.get_piece(4, 4)
    board.spawn_new_piece('P', 0, 3, 6)
    board.spawn_new_piece('P', 0, 3, 2)
    board.spawn_new_piece('P', 0, 5, 6)
    board.spawn_new_piece('P', 0, 5, 2)
    board.spawn_new_piece('P', 0, 6, 5)
    board.spawn_new_piece('P', 0, 6, 3)
    board.spawn_new_piece('P', 0, 2, 5)
    board.spawn_new_piece('P', 0, 2, 3)
    it "Can move to (5,6)" do
      expect(knight.can_move?(3, 2, board)).to be(false)
    end
    it "Can move to (5,2)" do
      expect(knight.can_move?(5, 2, board)).to be(false)
    end
    it "Can move to (3,6)" do
      expect(knight.can_move?(3, 6, board)).to be(false)
    end
    it "Can move to (3,2)" do
      expect(knight.can_move?(3, 2, board)).to be(false)
    end
    it "Can move to (6,3)" do
      expect(knight.can_move?(6, 3, board)).to be(false)
    end
    it "Can move to (6,5)" do
      expect(knight.can_move?(6, 5, board)).to be(false)
    end
    it "Can move to (2,3)" do
      expect(knight.can_move?(2, 3, board)).to be(false)
    end
    it "Can move to (2,5)" do
      expect(knight.can_move?(2, 5, board)).to be(false)
    end
  end
end