require_relative "board"
require_relative "piece"

module Chess
  class Pawn < Piece
    attr_reader :status

  end
end