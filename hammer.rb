require 'gosu'

class Hammer
  IMAGE_FILENAME = './assets/images/hammer.png'
  IMAGE_SIDE_LENGTH = 96

  attr_reader :x, :y, :width, :height

  def initialize
    @x = @y = 0
    @width = @height = IMAGE_SIDE_LENGTH
    @image =  Gosu::Image.new(IMAGE_FILENAME)
  end

  def draw
    @image.draw(@x - @width/2, @y - @height/2, 1, )
  end

  def move_to(x, y)
    @x = x
    @y = y
  end

  def whacks?(object)
    Gosu.distance(@x, @y, object.x, object.y) < IMAGE_SIDE_LENGTH/2
  end
end
