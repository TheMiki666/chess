require_relative "board"
require_relative "piece"

module Chess
  class King < Piece
    attr_reader :status, :check

  end
end