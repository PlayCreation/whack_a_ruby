require 'gosu'

class Ruby
  IMAGE_FILENAME = './assets/images/ruby.png'
  IMAGE_SIDE_LENGTH = 96

  attr_reader :x, :y, :width, :height, :velocity_x, :velocity_y

  def initialize(x_start, y_start)
    @x = x_start
    @y = y_start
    @width = @height = IMAGE_SIDE_LENGTH
    @velocity_x = @velocity_y = 5
    @visible = 0
    @image =  Gosu::Image.new(IMAGE_FILENAME)
  end

  def draw
    @image.draw(@x - @width/2, @y - @height/2, 1) if @visible > 0
  end

  def update_position
    @x += @velocity_x
    @y += @velocity_y
  end

  def update_velocity(x_limit, y_limit)
    @velocity_x *= -1 if @x + @width/2 > x_limit || @x - @width/2 < 0
    @velocity_y *= -1 if @y + @height/2 > y_limit || @y - @height/2 < 0
  end

  def update_visibility
    @visible -= 1
    @visible = 50 if @visible < -10 && rand < 0.01
  end

  def visible?
    @visible >= 0
  end

  def visible=(value)
    @visible = value
  end
end
