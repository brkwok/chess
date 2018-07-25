require_relative 'display'
require_relative 'player'

class Game
  attr_reader :board, :display, :p1, :p2
  attr_accessor :current_player

  def initialize(board, display, p1, p2)
    @board, @display, @p1, @p2 = board, display, p1, p2
    @current_player = p1
  end

  # def play
  #   until board.checkmate?(current_player)
  #     display.render
  #     start_pos, end_pos = current_player.get_move
  #     board.move_piece(current_player.color, start_pos, end_pos)
  #     switch_player!
  #     notify_player
  #   end
  # end
  def play
    until board.checkmate?(current_player.color)
      begin
        start_pos, end_pos = current_player.get_move
        board.move_piece(current_player.color, start_pos, end_pos)

        switch_player!
        notify_players
      rescue UserInputError => e
        e.message
        retry
      end
  end

  display.render
  puts "#{current_player} is checkmated."

  nil
end


  private
  def switch_player!
    @current_player == p1 ? @current_player = p2 : @current_player = p1
  end

  def notify_players
    if board.in_check?(current_player.color)
      puts "#{current_player.name} is in check!"
    else
      puts ""
    end
  end
end

if $PROGRAM_NAME == __FILE__
  board = Board.new
  display = Display.new(board)
  p1 = Player.new('bob', :black, display)
  p2 = Player.new('bobby', :white, display)
  game = Game.new(board, display, p1, p2)
  game.play
end
