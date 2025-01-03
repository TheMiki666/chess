require_relative ('../lib/referee')

describe Chess::Referee do
  describe "#analize_movement (white king moves to check)" do
    board = Chess::Board.new
    referee = Chess::Referee.new(board, nil)
    referee.new_match
    board.clear_board
    board.spawn_new_piece('K', 0, 4, 4)
    board.spawn_new_piece('K', 1, 4, 6)
    board.spawn_new_piece('R', 1, 1, 3)
    board.draw_board
    it "White king can move to (3,4)" do
      movement = {col1: 4, row1: 4, col2: 3, row2: 4}
      expect(referee.analize_movement(movement)).to eq(1)
    end
    it "White king can move to (5,4)" do
      movement = {col1: 4, row1: 4, col2: 5, row2: 4}
      expect(referee.analize_movement(movement)).to eq(1)
    end
    (3..5).each  do |x|
      it "White king can not move to a square in check(#{x},5)" do
        movement = {col1: 4, row1: 4, col2: x, row2: 5}
        expect(referee.analize_movement(movement)).to eq(-4)
      end
    end
    (3..5).each  do |x|
      it "White king can not move to a square in check(#{x},3)" do
        movement = {col1: 4, row1: 4, col2: x, row2: 3}
        expect(referee.analize_movement(movement)).to eq(-4)
      end
    end
  end
  describe "#analize_movement (black king moves to check)" do
    board = Chess::Board.new
    referee = Chess::Referee.new(board, nil)
    referee.new_match
    board.clear_board
    board.spawn_new_piece('K', 1, 4, 4)
    board.spawn_new_piece('K', 0, 4, 6)
    board.spawn_new_piece('R', 0, 1, 3)
    board.switch_turn
    board.draw_board
    it "Black king can move to (3,4)" do
      movement = {col1: 4, row1: 4, col2: 3, row2: 4}
      expect(referee.analize_movement(movement)).to eq(1)
    end
    it "Black king can move to (5,4)" do
      movement = {col1: 4, row1: 4, col2: 5, row2: 4}
      expect(referee.analize_movement(movement)).to eq(1)
    end
    (3..5).each  do |x|
      it "Black king can not move to a square in check(#{x},5)" do
        movement = {col1: 4, row1: 4, col2: x, row2: 5}
        expect(referee.analize_movement(movement)).to eq(-4)
      end
    end
    (3..5).each  do |x|
      it "Black king can not move to a square in check(#{x},3)" do
        movement = {col1: 4, row1: 4, col2: x, row2: 3}
        expect(referee.analize_movement(movement)).to eq(-4)
      end
    end
  end

  describe "#analize_movement (trying to move a pinned piece)" do
    board = Chess::Board.new
    referee = Chess::Referee.new(board, nil)
    referee.new_match
    board.clear_board
    board.spawn_new_piece('K', 1, 1, 8)
    board.spawn_new_piece('K', 0, 5, 1)
    board.spawn_new_piece('N', 0, 5, 3)
    board.spawn_new_piece('B', 0, 4, 2)
    board.spawn_new_piece('R', 1, 5, 8)
    board.spawn_new_piece('Q', 1, 1, 5)
    board.draw_board
    it "Knight can not move anywhere" do
      movement = {col1: 5, row1: 3, col2: 7, row2: 2}
      expect(referee.analize_movement(movement)).to eq(-4)
    end
    it "Knight can not move anywhere" do
      movement = {col1: 5, row1: 3, col2: 7, row2: 4}
      expect(referee.analize_movement(movement)).to eq(-4)
    end
    it "Knight can not move anywhere" do
      movement = {col1: 5, row1: 3, col2: 4, row2: 1}
      expect(referee.analize_movement(movement)).to eq(-4)
    end
    it "Knight can not move anywhere" do
      movement = {col1: 5, row1: 3, col2: 4, row2: 5}
      expect(referee.analize_movement(movement)).to eq(-4)
    end
    it "Bishop can not move to (3,1)" do
      movement = {col1: 4, row1: 2, col2: 3, row2: 1}
      expect(referee.analize_movement(movement)).to eq(-4)
    end
    it "Bishop can move to (2,4)" do
      movement = {col1: 4, row1: 2, col2: 2, row2: 4}
      expect(referee.analize_movement(movement)).to eq(1)
    end
    it "Bishop can capture queen" do
      movement = {col1: 4, row1: 2, col2: 1, row2: 5}
      expect(referee.analize_movement(movement)).to eq(1)
    end
    it "King can move" do
      movement = {col1: 5, row1: 1, col2: 6, row2: 1}
      expect(referee.analize_movement(movement)).to eq(1)
    end
  end

  describe "#analize_movement (already in a check situation)" do
    board = Chess::Board.new
    referee = Chess::Referee.new(board, nil)
    referee.new_match
    board.clear_board
    board.spawn_new_piece('K', 1, 8, 8)
    board.spawn_new_piece('K', 0, 1, 1)
    board.spawn_new_piece('R', 1, 2, 7)
    board.spawn_new_piece('R', 0, 8, 1)
    board.spawn_new_piece('B', 1, 5, 4)
    board.switch_turn
    board.draw_board
    it "King can escape to (7,8)" do
      movement = {col1: 8, row1: 8, col2: 7, row2: 8}
      expect(referee.analize_movement(movement)).to eq(1)
    end
    it "King can escape to (7,7)" do
      movement = {col1: 8, row1: 8, col2: 7, row2: 7}
      expect(referee.analize_movement(movement)).to eq(1)
    end
    it "King can not move to escape to (8,7)" do
      movement = {col1: 8, row1: 8, col2: 8, row2: 7}
      expect(referee.analize_movement(movement)).to eq(-4)
    end
    it "Rook can block the way to the king" do
      movement = {col1: 2, row1: 7, col2: 8, row2: 7}
      expect(referee.analize_movement(movement)).to eq(1)
    end
    it "Rook can not move anywhere else" do
      movement = {col1: 2, row1: 7, col2: 1, row2: 7}
      expect(referee.analize_movement(movement)).to eq(-4)
    end
    it "Bishop can capture the rook" do
      movement = {col1: 5, row1: 4, col2: 8, row2: 1}
      expect(referee.analize_movement(movement)).to eq(1)
    end
    it "Bishop can block the way to the king" do
      movement = {col1: 5, row1: 4, col2: 8, row2: 7}
      expect(referee.analize_movement(movement)).to eq(1)
    end
    it "Bishop can not move anywhere else" do
      movement = {col1: 5, row1: 4, col2: 2, row2: 1}
      expect(referee.analize_movement(movement)).to eq(-4)
    end

    
  end 
 
end