require_relative ('../lib/referee')

describe Chess::Referee do
  describe "#analize_movement (turn of white player)" do
    board = Chess::Board.new
    referee = Chess::Referee.new(board, nil)
    referee.new_match
    (1..8).each do |y|
      (3..6).each do |x|
        it ("returns 0 if we start in a empty square (#{y},#{x})") do
          movement = {col1: y, row1: x, col2: 6, row2: 8}
          expect(referee.analize_movement(movement)).to eq(0)
        end
      end
    end
    (1..8).each do |y|
      (7..8).each do |x|
        it ("returns -1 if we start in a square with an enemy piece (#{y},#{x})") do
          movement = {col1: y, row1: x, col2: 6, row2: 8}
          expect(referee.analize_movement(movement)).to eq(-1)
        end
      end
    end
    (1..8).each do |y|
      (1..2).each do |x|
        it ("returns -2 if we finish in a square with an allied piece (#{y},#{x})") do
          movement = {col1: 1, row1: 1, col2: y, row2: x}
          expect(referee.analize_movement(movement)).to eq(-2)
        end
      end
    end
    (1..8).each do |y|
      (1..2).each do |x|
        it ("returns -3 if the movement is not possible(#{y},#{x}) to (#{y},5)") do
          movement = {col1: y, row1: x, col2: y, row2: 5}
          expect(referee.analize_movement(movement)).to eq(-3)
        end
      end
    end
    (1..8).each do |y|
      (3..4).each do |x|
        it ("returns 1 if the movement is possible(#{y},2) to (#{y},#{x})") do
          movement = {col1: y, row1: 2, col2: y, row2: x}
          expect(referee.analize_movement(movement)).to eq(1)
        end
      end
    end
    it ("returns 1 if the movement is possible N(2,1) to (1,3)") do
      movement = {col1: 2, row1: 1, col2: 1, row2: 3}
      expect(referee.analize_movement(movement)).to eq(1)
    end
    it ("returns 1 if the movement is possible N(2,1) to (3,3)") do
      movement = {col1: 2, row1: 1, col2: 3, row2: 3}
      expect(referee.analize_movement(movement)).to eq(1)
    end
    it ("returns 1 if the movement is possible N(7,1) to (6,3)") do
      movement = {col1: 7, row1: 1, col2: 6, row2: 3}
      expect(referee.analize_movement(movement)).to eq(1)
    end
    it ("returns 1 if the movement is possible N(7,1) to (8,3)") do
      movement = {col1: 7, row1: 1, col2: 8, row2: 3}
      expect(referee.analize_movement(movement)).to eq(1)
    end
  end
  
  describe "#analize_movement (turn of black player)" do
  board = Chess::Board.new
  referee = Chess::Referee.new(board, nil)
  referee.new_match
  board.switch_turn
  (1..8).each do |y|
    (3..6).each do |x|
      it ("returns 0 if we start in a empty square (#{y},#{x})") do
        movement = {col1: y, row1: x, col2: 6, row2: 8}
        expect(referee.analize_movement(movement)).to eq(0)
      end
    end
  end
  (1..8).each do |y|
    (1..2).each do |x|
      it ("returns -1 if we start in a square with an enemy piece (#{y},#{x})") do
        movement = {col1: y, row1: x, col2: 6, row2: 8}
        expect(referee.analize_movement(movement)).to eq(-1)
      end
    end
  end
  (1..8).each do |y|
    (7..8).each do |x|
      it ("returns -2 if we finish in a square with an allied piece (#{y},#{x})") do
        movement = {col1: 1, row1: 8, col2: y, row2: x}
        expect(referee.analize_movement(movement)).to eq(-2)
      end
    end
  end
  (1..8).each do |y|
    (7..8).each do |x|
      it ("returns -3 if the movement is not possible(#{y},#{x}) to (#{y},4)") do
        movement = {col1: y, row1: x, col2: y, row2: 4}
        expect(referee.analize_movement(movement)).to eq(-3)
      end
    end
  end
  (1..8).each do |y|
    (5..6).each do |x|
      it ("returns 1 if the movement is possible(#{y},2) to (#{y},#{x})") do
        movement = {col1: y, row1: 7, col2: y, row2: x}
        expect(referee.analize_movement(movement)).to eq(1)
      end
    end
  end
  it ("returns 1 if the movement is possible N(2,8) to (1,6)") do
    movement = {col1: 2, row1: 8, col2: 1, row2: 6}
    expect(referee.analize_movement(movement)).to eq(1)
  end
  it ("returns 1 if the movement is possible N(2,8) to (3,6)") do
    movement = {col1: 2, row1: 8, col2: 3, row2: 6}
    expect(referee.analize_movement(movement)).to eq(1)
  end
  it ("returns 1 if the movement is possible N(7,8) to (6,6)") do
    movement = {col1: 7, row1: 8, col2: 6, row2: 6}
    expect(referee.analize_movement(movement)).to eq(1)
  end
  it ("returns 1 if the movement is possible N(7,8) to (8,6)") do
    movement = {col1: 7, row1: 8, col2: 8, row2: 6}
    expect(referee.analize_movement(movement)).to eq(1)
  end
end


end