require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display
  attr_reader :board, :cursor, :selected_pos

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
    @selected_pos = cursor.selected_pos
  end

  def disp_board
    @board.rows.map.with_index do |row, i|
      each_row(row, i)
    end
  end

  def each_row(row, i)
    row.map.with_index do |piece, j|
      if cursor.cursor_pos == [i, j] && cursor.selected
        piece.to_s.colorize(background: :light_cyan)
      elsif selected_pos == [i, j]
        piece.to_s.colorize(background: :cyan)
      elsif cursor.cursor_pos == [i, j]
        piece.to_s.colorize(background: :light_yellow)
      elsif (i + j).odd?
        piece.to_s.colorize(background: :light_black)
      else
        piece.to_s.colorize(background: :light_red)
      end
    end
  end

  def render
    system("clear")
    disp_board.each do |row|
      puts row.join("")
    end
    puts "Use Arrow keys, WASD to move AND enter to select a piece"
  end
end
