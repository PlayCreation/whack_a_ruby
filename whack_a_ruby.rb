require 'gosu'

require_relative 'ruby'
require_relative 'hammer'
require_relative 'scoreboard'

class WhackARuby < Gosu::Window
  GAME_DURATION_SEC = 30

  def initialize
    @x_size = 800
    @y_size = 600
    super(@x_size, @y_size)
    self.caption = 'Whack the Ruby!'

    @ruby = Ruby.new(200, 200)
    @hammer = Hammer.new
    @hit = 0

    @scoreboard = Scoreboard.new
    @font = Gosu::Font.new(30)

    @playing = true
    @start_time = 0
  end

  def draw
    @ruby.draw
    @hammer.draw

    if @hit == 0
      c = Gosu::Color::NONE
    elsif @hit == 1
      c = Gosu::Color::GREEN
    elsif @hit == -1
      c = Gosu::Color::RED
    end
    draw_quad(0, 0, c, 800, 0, c, 800, 600, c, 0, 600, c)
    @hit = 0
    @scoreboard.draw(@font, 700, 20, 2)

    @font.draw(@time_left.to_s, 20, 20, 2)

    if !@playing
      Gosu::Font.new(50).draw("GAME OVER", 300, 250, 3)
      @font.draw('Press the Space Bar to Play Again', 200, 325, 3)
      @ruby.visible = 20
    end
  end

  def button_down(id)
    if id == Gosu::MsLeft && @playing
      if @hammer.whacks?(@ruby) && @ruby.visible?
        @hit = 1
        @scoreboard.add_points 5
      else
        @hit = -1
        @scoreboard.subtract_points 1
      end
    elsif (id == Gosu::KbSpace)
      @playing = true
      @ruby.visible = -10
      @start_time = Gosu.milliseconds
      @score = 0
    end
  end

  def update
    if @playing
      @ruby.update_position
      @ruby.update_velocity(@x_size, @y_size)
      @ruby.update_visibility
      @hammer.move_to(mouse_x, mouse_y)

      @time_left = GAME_DURATION_SEC - (Gosu.milliseconds - @start_time)/1000
      @playing = false if @time_left == 0
    end
  end
end

window = WhackARuby.new
window.show
