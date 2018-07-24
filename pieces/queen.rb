require_relative 'piece'
require_relative 'slideable'

class Queen < Piece
  include SlidingPiece

  def symbol
    "\u265B".colorize(color)
  end

  def move_dirs
    horizontal_dirs + diagonal_dirs
  end
end
