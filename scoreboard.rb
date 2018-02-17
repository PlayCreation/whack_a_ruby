require 'gosu'

class Scoreboard
  attr_accessor :score

  def initialize
    @score = 0
  end

  def add_points(points)
    @score += points
  end

  def subtract_points(points)
    @score -= points
  end

  def draw(renderer, x, y, z)
    renderer.draw(@score.to_s, x, y, z)
  end
end