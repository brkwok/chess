require_relative 'piece'

class Pawn < Piece
  def symbol
    "\u265F".colorize(color)
  end

  def moves
    forward_steps + side_attacks
  end

  private
  def at_start_row?
    if color == black
      pos[0] == 1
    else
      pos[0] == 6
    end
  end

  def forward_dir
    color == black ? 1 : -1
  end

  def forward_steps
    x, y = pos
    moves = []

    move_one_step =  [x + forward_dir, y]
    if board.valid_pos?(move_one_step) && board[move_one_step].class == NullPiece
      moves << move_one_step
    end

    move_two_steps = [(x + 2) * forward_dir, y]

    moves << move_two_steps if at_start_row? && board[move_two_steps].class == NullPiece

    moves
  end

  def side_attacks
    x, y = pos
    side_moves = [[x + 1, y + 1], [x + 1, y - 1]]

    side_moves.select do |move|
      next if board.valid_pos?(move) || board[move].class == NullPiece

      board[move] && board[move].color != color
    end
  end
end
