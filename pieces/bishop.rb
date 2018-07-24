require_relative 'piece'
require_relative 'slideable'

class Bishop < Piece
  include SlidingPiece

  def symbol
    "\u265D".colorize(color)
  end

  def move_dirs
    diagonal_dirs
  end
end
