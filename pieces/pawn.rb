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
    if color == :black
      pos[0] == 6
    else
      pos[0] == 1
    end
  end

  def forward_dir
    color == :black ? -1 : 1
  end

  def forward_steps
    x, y = pos
    moves = []
    move_one_step =  [x + forward_dir, y]
    if board.valid_pos?(move_one_step) && board[move_one_step].empty?
      moves << move_one_step
    end

    move_two_steps = [x + (2 * forward_dir), y]
    moves << move_two_steps if at_start_row? && board[move_two_steps].empty?

    moves
  end

  # def side_attacks
  #   x, y = pos
  #   side_moves = [[x + forward_dir, y + 1], [x + forward_dir, y - 1]]
  #
  #   new_moves = side_moves.select do |move|
  #
  #     board.valid_pos?(move) || board[move].class != NullPiece
  #     # if !board.valid_pos?(move)
  #     #   false
  #     # elsif board[move].empty?
  #     #   false
  #     # end
  #     #
  #     board[move].empty? && board[move].color != color
  #   end
  #
  #   new_moves
  # end
  def side_attacks
    i, j = pos

    side_moves = [[i + forward_dir, j - 1], [i + forward_dir, j + 1]]

    side_moves.select do |new_pos|
      next false unless board.valid_pos?(new_pos)
      next false if board[new_pos].empty?

      threatened_piece = board[new_pos]
      threatened_piece && threatened_piece.color != color
    end
  end
end
