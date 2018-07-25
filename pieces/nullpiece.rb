require_relative 'piece.rb'
require 'singleton'

class NullPiece < Piece
include Singleton
  def initialize

  end

  def color
    "color"
  end

  def moves

  end

  def symbol
    " "
  end
end
