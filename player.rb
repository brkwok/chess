require_relative 'display.rb'

class Player
  attr_reader :display, :name, :color
  def initialize(name, color, display)
    @name, @color, @display = name, color, display
  end

  # def get_move
  #   start_pos, end_pos = nil, nil
  #
  #   until start_pos && end_pos
  #       display.render
  #       puts "Choose a piece to move #{name}"
  #       start_pos = display.cursor.get_input
  #
  #       puts "Choose a position to move your piece"
  #       end_pos = display.cursor.get_input
  #   end
  #   [start_pos, end_pos]
  # end
  def get_move
    start_pos, end_pos = nil, nil

    until start_pos && end_pos
      display.render

      if start_pos
        puts "#{color}'s turn. Move to where?"
        end_pos = display.cursor.get_input

      else
        puts "#{color}'s turn. Move from where?"
        start_pos = display.cursor.get_input

      end
    end

    [start_pos, end_pos]
  end
end
