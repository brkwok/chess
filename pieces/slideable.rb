module SlidingPiece
  HORIZONTAL_DIRS = [
    [-1, 0],
    [1, 0],
    [0, 1],
    [0, -1]
  ].freeze

  DIAGONAL_DIRS = [
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1]
  ].freeze

  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
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

  # def grow_unblocked_moves_in_dir(dx, dy)
  #   cx, cy = pos
  #   moves = []
  #
  #   loop do
  #     cx, cy = cx + dx, cy + dy
  #     pos = [cx, cy]
  #
  #     break if board.valid_pos?(pos)
  #
  #     if board.empty
  #       moves << pos
  #     else
  #       if board[pos].color != color
  #         moves << pos
  #       end
  #
  #       break
  #     end
  #   end
  #
  #   moves
  # end
  def grow_unblocked_moves_in_dir(dx, dy)
    cur_x, cur_y = pos
    moves = []
    loop do
      cur_x, cur_y = cur_x + dx, cur_y + dy
      pos = [cur_x, cur_y]

      break unless board.valid_pos?(pos)

      if board[pos].empty?
        moves << pos
      else
        # can take an opponent's piece
        moves << pos if board[pos].color != color

        # can't move past blocking piece
        break
      end
    end

    moves
  end
end
