module SteppingPiece
  def moves
    moves = []
    cx, cy = pos

    move_diffs.each do |el|
      debugger
      dx, dy = el
      new_pos = [cx + dx, cy + dy]

      next unless board.valid_pos?(new_pos)

      if board[new_pos].empty?
        moves << new_pos
      elsif board[new_pos].color != color
        moves << new_pos
      end
    end

    moves
  end
  # def moves
  #   move_diffs.each_with_object([]) do |(dx, dy), moves|
  #     cur_x, cur_y = pos
  #     pos = [cur_x + dx, cur_y + dy]
  #
  #     next unless board.valid_pos?(pos)
  #
  #     if board.empty
  #       moves << pos
  #     elsif board[pos].color != color
  #       moves << pos
  #     end
  #   end
  #
  #   moves
  # end

  def move_diffs
    raise NotImplementedError
  end
end
