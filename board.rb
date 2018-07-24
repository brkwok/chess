require_relative 'nullpiece.rb'

class ChessGameError < StandardError; end
class UserInputError < ChessGameError; end

class Board

  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
    @sentinel = NullPiece.instance
  end

  def populate
    @board.each_with_index do |row, i|
      row.each_with_index do |col, j|
        if i == 0 || i == 1
          @board[i][j] = Piece.new(:B, @board, [i, j])
        elsif i == 6 || i == 7
          @board[i][j] = Piece.new(:W, @board, [i, j])
        else
          @board[i][j] = @sentinel
        end
      end
    end
  end


  def move_piece(start_pos, end_pos)
    raise UserInputError.new('Start position empty') if self[start_pos].class == NullPiece
    raise UserInputError.new('Not a valid move') if start_pos == end_pos
    self[end_pos] = self[start_pos]
    self[start_pos] = @sentinel
    self[start_pos].pos = end_pos
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @board[row][col] = val
  end

end
