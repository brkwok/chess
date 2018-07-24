class Piece
  attr_accessor :pos
  attr_reader :color, :board

  def initialize(color, board, pos)
    @color, @board, @pos = color, board, pos
  end

  def to_s
    " #{symbol}  "
  end

  def empty?
    return true if self.class == NullPiece
    false
  end

  def valid_moves
    moves.reject do |move|
      move_into_check?(move)
    end
  end

  def pos=(val)
    pos = val
  end

  def symbol
    raise NotImplementedError
  end

  private
  def move_into_check?(end_pos)
    validation_board = board.dup
    validation_board.move_piece!(pos, end_pos)
    validation_board.in_check?(color)
  end
end
