require_relative "board"
require_relative "piece"

module Chess
  class Pawn < Chess::Piece
    attr_reader :status

  end
end