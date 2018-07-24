require_relative 'piece'
require_relative 'stepable'

class King < Piece
  include SteppingPiece

  def symbol
    "\u265A".colorize(color)
  end

  def move_diffs
    [[1,1], [-1,1], [-1,-1] ,[1,-1], [1,0],[-1,0], [0,-1], [0,1]]
  end
end
