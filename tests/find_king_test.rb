require_relative ("../lib/referee")

#After passing these test, method Referee#find_king will become private, so the tests will fail
describe Chess::Referee do
  describe "#find_king with just two pieces" do
  board = Chess::Board.new
  referee = Chess::Referee.new(board, nil)
  referee.new_match
  board.clear_board
  board.spawn_new_piece('K', 0, 2, 6)
  board.spawn_new_piece('K', 1, 7, 3)
    it ("finds white king") do
      expect(referee.find_king(0)[0]).to eq(2)
    end    
    it ("finds white king") do
      expect(referee.find_king(0)[1]).to eq(6)
    end
    it ("finds black king") do
      expect(referee.find_king(1)[0]).to eq(7)
    end
    it ("finds black king") do
      expect(referee.find_king(1)[1]).to eq(3)
    end
  end

  describe "#find_king in the intial position" do
  board = Chess::Board.new
  referee = Chess::Referee.new(board, nil)
  referee.new_match
    it ("finds white king") do
      expect(referee.find_king(0)[0]).to eq(5)
    end    
    it ("finds white king") do
      expect(referee.find_king(0)[1]).to eq(1)
    end
    it ("finds black king") do
      expect(referee.find_king(1)[0]).to eq(5)
    end
    it ("finds black king") do
      expect(referee.find_king(1)[1]).to eq(8)
    end
  end
end

