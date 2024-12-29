require_relative "board"
require_relative "piece"

module Chess
  class Rook < Chess::Piece
    attr_reader :status

  end
end