require_relative 'piece'
require_relative 'stepable'

class Knight < Piece
  include SteppingPiece

  def symbol
    "\u265E".colorize(color)
  end

  def move_diffs
    [
      [1, 2],
      [2, 1],
      [-2, 1],
      [2, -1],
      [-1, 2],
      [1, -2],
      [-2, -1],
      [-1, -2]
    ]
  end
end
