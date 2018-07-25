require_relative 'pieces'
require 'byebug'

class ChessGameError < StandardError; end
class UserInputError < ChessGameError; end

class Board

  attr_accessor :rows

  def initialize(fill_in = true)
    @rows = Array.new(8) { Array.new(8) }
    @sentinel = NullPiece.instance
    populate(fill_in)
  end



  def [](pos)
    row, col = pos
    @rows[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @rows[row][col] = val
  end

  def empty?
    self[pos].empty?
  end

  def valid_pos?(pos)
    # row, col = pos
    # return false if row < 0 || row > 7 || col < 0 || col > 7
    # true
    pos.all? { |position| position.between?(0, 7) }
  end

  def checkmate?(color)
    king = find_king(color)
    return false unless in_check?(color)

    king.valid_moves.empty?
  end

  def in_check?(color)
    king = find_king(color)

    pieces.any? do |piece|
      piece.color != color && piece.moves.include?(king)
    end
  end

  def find_king(color)
    pieces.find { |piece| piece.color == color && piece.class == King }
  end

  def pieces
    @rows.flatten.reject do |piece|
      piece.empty?
    end
  end

  def dup
    dup_board = Board.new(false)

    pieces.each do |piece|
      dup_piece = piece.class.new(piece.color, dup_board, piece.pos)
      dup_board[piece.pos] = dup_piece
    end

    dup_board
  end


  def move_piece(color, start_pos, end_pos)
    raise UserInputError.new('Start position empty') if self[start_pos].empty?
    raise UserInputError.new('Not a valid move') if start_pos == end_pos
    raise UserInputError.new('You cannot put yourself in check') unless self[start_pos].valid_moves.include?(end_pos)

    move_piece!(color, start_pos, end_pos)
  end

  def move_piece!(color, start_pos, end_pos)
    raise UserInputError.new("Invalid move") unless self[start_pos].moves.include?(end_pos)

    self[end_pos] = self[start_pos]
    self[start_pos] = @sentinel
    self[start_pos].pos = end_pos
  end

  private
  def populate(fill_in = true)
    if fill_in == true
      @rows.each_with_index do |row, i|
        row.each_with_index do |col, j|
          if i == 0 && (j == 0 || j == 7)
           self[[i, j]] = Rook.new(:white, self, [i, j])
         elsif i == 7 && (j == 0 || j == 7)
           self[[i, j]] = Rook.new(:black, self, [i, j])
         elsif i == 1
           self[[i, j]] = Pawn.new(:white, self, [i, j])
         elsif i == 6
           self[[i, j]] = Pawn.new(:black, self, [i, j])
         elsif i == 0 && (j == 1 || j == 6)
           self[[i, j]] = Knight.new(:white, self, [i, j])
         elsif i == 7 && (j == 1|| j == 6)
           self[[i, j]] = Knight.new(:black, self, [i, j])
         elsif i == 0 && (j == 2 || j == 5)
           self[[i, j]] = Bishop.new(:white, self, [i, j])
         elsif i == 7 && (j == 2 || j == 5)
           self[[i, j]] = Bishop.new(:black, self, [i, j])
         elsif i == 0 && j == 3
           self[[i, j]] = King.new(:white, self, [i, j])
         elsif i == 7 && j == 3
           self[[i, j]] = King.new(:black, self, [i, j])
         elsif i == 0 && j == 4
           self[[i, j]] = Queen.new(:white, self, [i, j])
         elsif i == 7 && j == 4
           self[[i, j]] = Queen.new(:black, self, [i, j])
         else
           self[[i, j]] = @sentinel
          end
        end
      end

    else
      @rows.each_with_index do |row, i|
        row.each_with_index do |col, j|
          self[[i, j]] = @sentinel
        end
      end
    end
  end
end
