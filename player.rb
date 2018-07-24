require_relative 'display.rb'

class Player
  attr_reader :display, :name, :color
  def initialize(name, color, display)
    @name, @color, @display = name, color, display
  end

  def get_move
    start_pos, end_pos = nil, nil

    until start_pos && end_pos
        begin
        display.render
        puts "Choose a piece to move #{name}"
        start_pos = display.cursor.get_input

        puts "Choose a position to move your piece"
        end_pos = display.cursor.get_input

      rescue UserInputError => e
        e.message("Invalid move!")
        retry
      end
    end
    [start_pos, end_pos]
  end
end
