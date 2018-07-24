require_relative 'pieces'
require 'byebug'

class ChessGameError < StandardError; end
class UserInputError < ChessGameError; end

class Board

  attr_accessor :rows

  def initialize
    @rows = Array.new(8) { Array.new(8) }
    @sentinel = NullPiece.instance
    populate
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
    @rows[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @rows[row][col] = val
  end

  def valid_pos?(pos)
    row, col = pos
    return false if row < 0 || row > 7 || col < 0 || col > 7
    true
  end

  private
  def populate
    @rows.each_with_index do |row, i|
      row.each_with_index do |col, j|
        if i == 0 || i == 1
          self[[i, j]] = Piece.new(:B, @rows, [i, j])
        elsif i == 6 || i == 7
          self[[i, j]] = Piece.new(:W, @rows, [i, j])
        else
          self[[i, j]] = @sentinel
        end
      end
    end
  end
end
