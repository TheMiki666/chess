require_relative ("../lib/pawn")
require_relative ("../lib/knight")
require_relative ("../lib/bishop")
require_relative ("../lib/rook")
require_relative ("../lib/queen")
require_relative ("../lib/king")

describe "#get kind" do
  it "It's a pawn" do
    piece = Chess::Pawn.new(0,1,1)
    expect(piece.get_kind).to eq('P')
  end
  it "It's a knight" do
    piece = Chess::Knight.new(0,1,1)
    expect(piece.get_kind).to eq('N')
  end
  it "It's a bishop" do
    piece = Chess::Bishop.new(0,1,1)
    expect(piece.get_kind).to eq('B')
  end
  it "It's a rook" do
    piece = Chess::Rook.new(0,1,1)
    expect(piece.get_kind).to eq('R')
  end
  it "It's a queen" do
    piece = Chess::Queen.new(0,1,1)
    expect(piece.get_kind).to eq('Q')
  end
  it "It's a king" do
    piece = Chess::King.new(0,1,1)
    expect(piece.get_kind).to eq('K')
  end
end