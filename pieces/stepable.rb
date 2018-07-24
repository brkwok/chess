module SteppingPiece
  def moves
    move_diffs.each do |dx, dy|
      moves = []
      cx, cy = pos
      pos = [cx + dx, cy + dy]

      next unless board.valid_pos?(pos)

      if board.empty?(pos)
        moves << pos
      elsif board[pos].color != self.color
        moves << pos
      end
    end

    moves
  end

  def move_diffs
    raise NotImplementedError
  end
end
