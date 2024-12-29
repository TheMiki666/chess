require_relative "board"
require_relative "piece"

module Chess
  class Queen < Piece
    attr_reader :status

  end
end