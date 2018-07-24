module SlidingPiece
  HORIZONTAL = [
    [-1, 0],
    [1, 0],
    [0, 1],
    [0, -1]
  ].freeze

  DIAGONAL = [
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1]
  ].freeze

  def horizontal_dirs
    HORIZONTAL
  end

  def diagonal_dirs
    DIAGONAL
  end

  def moves
    moves = []

    move_dirs.each do |dx, dy|
      moves.concat(grow_unblocked_moves_in_dir(dx, dy))
    end
  end

  def move_dirs
    raise NotImplementedError
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    cx, cy = pos

    while true
      cx, cy = cx + dx, cy + dy
      pos = [cx, cy]

      break if board.valid_pos?(pos)

      if board.empty?(pos)
        moves << pos
      else
        if board[pos].color != color
          moves << pos
        end

        break
      end
    end

    moves
  end
end
