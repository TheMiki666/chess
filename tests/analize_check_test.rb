require_relative ('../lib/board')

describe Chess::Board do
  describe "#analize_check with a Rook" do
  board = Chess::Board.new
  board.spawn_new_piece('R', 1, 4, 4)
  board.draw_board
    (1..3).each do |x|
      it "(#{x},4) is in check" do
        expect(board.analize_check(x,4,1)).to be(true)
      end
    end
    (5..8).each do |x|
      it "(#{x},4) is in check" do
        expect(board.analize_check(x,4,1)).to be(true)
      end
    end
    (1..3).each do |x|
      it "(4,#{x}) is in check" do
        expect(board.analize_check(4,x,1)).to be(true)
      end
    end
    (5..8).each do |x|
      it "(4,#{x}) is in check" do
        expect(board.analize_check(4,x,1)).to be(true)
      end
    end
    it "(4,4) is not in check" do
      expect(board.analize_check(4,4,1)).to be(false)
    end
    it "(6,6) is not in check" do
      expect(board.analize_check(6,6,1)).to be(false)
    end
    it "(1,1) is not in check" do
      expect(board.analize_check(1,1,1)).to be(false)
    end
    it "(1,6) is not in check" do
      expect(board.analize_check(1,6,1)).to be(false)
    end
    it "(6,1) is not in check" do
      expect(board.analize_check(6,1,1)).to be(false)
    end
    it "an allied piece in (4,8) is not in check" do
      expect(board.analize_check(4,8,0)).to be(false)
    end
  end

  describe "#analize_check with two Rooks" do
    board = Chess::Board.new
    board.spawn_new_piece('R', 1, 4, 4)
    board.spawn_new_piece('R', 1, 7, 4)
    board.draw_board
    (1..8).each do |x|
      it "(#{x},4) is in check" do
        expect(board.analize_check(x,4,1)).to be(true)
      end
    end
    (1..8).each do |x|
      it "(4, #{x}) is in check" do
        expect(board.analize_check(4,x,1)).to be(true)
      end
    end
    (1..8).each do |x|
      it "(7, #{x}) is in check" do
        expect(board.analize_check(7,x,1)).to be(true)
      end
    end
    (1..3).each do |x|
      it "(2, #{x}) is not in check" do
        expect(board.analize_check(2,x,1)).to be(false)
      end
    end
    (5..8).each do |x|
      it "(2, #{x}) is not in check" do
        expect(board.analize_check(2,x,1)).to be(false)
      end
    end
    (1..8).each do |x|
      if x != 4 && x != 7
        it "(#{x},1) is not in check" do
          expect(board.analize_check(x,1,1)).to be(false)
        end
      end
    end
    (1..8).each do |x|
      it "(#{x},4) for a black piece is not in check" do
        expect(board.analize_check(x,4,0)).to be(false)
      end
    end
  end

  describe "#analize_check with initial board" do
    board = Chess::Board.new
    board.initial_position
    board.draw_board

    (1..8).each do |x|
      it "(#{x},3) is check for black pieces" do
        expect(board.analize_check(x,3,0)).to be(true)
      end
    end
    (1..8).each do |x|
      it "(#{x},6) is check for white pieces" do
        expect(board.analize_check(x,6,1)).to be(true)
      end
    end
    (1..8).each do |x|
      it "(#{x},3) is not check for white pieces" do
        expect(board.analize_check(x,3,1)).to be(false)
      end
    end
    (1..8).each do |x|
      it "(#{x},6) is not check for black pieces" do
        expect(board.analize_check(x,6,0)).to be(false)
      end
    end
    (1..8).each do |y|
      (4..5).each do |x|
        it "(#{y},#{x}) is not check for black pieces" do
          expect(board.analize_check(y,x,0)).to be(false)
        end
        it "(#{y},#{x}) is not check for white pieces" do
          expect(board.analize_check(y,x,1)).to be(false)
        end
      end
    end
    (1..8).each do |x|
      it "(#{x},7) (pawn line) is check for white pieces" do
        expect(board.analize_check(x,7,1)).to be(true)
      end
      it "(#{x},7) (pawn line) is not check for black pieces" do
        expect(board.analize_check(x,7,0)).to be(false)
      end
      it "(#{x},2) (pawn line) is check for black pieces" do
        expect(board.analize_check(x,2,0)).to be(true)
      end
      it "(#{x},2) (pawn line) is not check for white pieces" do
        expect(board.analize_check(x,2,1)).to be(false)
      end
    end
    (2..6).each do |x|
      it "(#{x},8) (figure line) is check for white pieces" do
        expect(board.analize_check(x,8,1)).to be(true)
      end
      it "(#{x},8) (figure line) is not check for black pieces" do
        expect(board.analize_check(x,8,0)).to be(false)
      end
      it "(#{x},1) (figure line) is check for black pieces" do
        expect(board.analize_check(x,1,0)).to be(true)
      end
      it "(#{x},1) (figure line) is not check for white pieces" do
        expect(board.analize_check(x,1,1)).to be(false)
      end
    end
    it "(1,1) (rook square) is not check for white pieces" do
      expect(board.analize_check(1,1,1)).to be(false)
    end
    it "(1,1) (rook square) is not check for black pieces" do
      expect(board.analize_check(1,1,0)).to be(false)
    end
    it "(8,1) (rook square) is not check for white pieces" do
      expect(board.analize_check(8,1,1)).to be(false)
    end
    it "(8,1) (rook square) is not check for black pieces" do
      expect(board.analize_check(8,1,0)).to be(false)
    end
    it "(1,8) (rook square) is not check for white pieces" do
      expect(board.analize_check(1,8,1)).to be(false)
    end
    it "(1,8) (rook square) is not check for black pieces" do
      expect(board.analize_check(1,8,0)).to be(false)
    end
    it "(8,8) (rook square) is not check for white pieces" do
      expect(board.analize_check(8,8,1)).to be(false)
    end
    it "(8,8) (rook square) is not check for black pieces" do
      expect(board.analize_check(8,8,0)).to be(false)
    end

  end
end



