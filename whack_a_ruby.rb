require 'gosu'

require_relative 'ruby'
require_relative 'hammer'
require_relative 'scoreboard'

class WhackARuby < Gosu::Window
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
  end

  def button_down(id)
    if id == Gosu::MsLeft
      if @hammer.whacks?(@ruby) && @ruby.visible?
        @hit = 1
        @scoreboard.add_points 5
      else
        @hit = -1
        @scoreboard.subtract_points 1
      end
    end
  end

  def update
    @ruby.update_position
    @ruby.update_velocity(@x_size, @y_size)
    @ruby.update_visibility
    @hammer.move_to(mouse_x, mouse_y)
  end
end

window = WhackARuby.new
window.show
