require_relative 'piece'
require_relative 'slideable'

class Rook < Piece
  include SlidingPiece

  def symbol
    "\u265C".colorize(color)
  end

  private
  def move_dirs
    horizontal_dirs
  end
end
