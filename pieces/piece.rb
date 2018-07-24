class Piece
  attr_accessor :pos
  attr_reader :color, :board

  def initialize(color, board, pos)
    @color, @board, @pos = color, board, pos
  end

  def to_s
    " #{symbol} "
  end

  def empty?
    return true if self.class == NullPiece
    false
  end

  def valid_moves

  end

  def pos=(val)
    pos = val
  end

  def symbol
    @color.to_s
  end

  private
  def move_into_check?(end_pos)

  end
end
