require_relative 'camera'
require_relative 'draw_component'

class FollowCamera < Camera

  attr_accessor :follow
  def initialize(width, height, scale_x = 1, scale_y = 1,xport = 0, yport = 0, x = 0, y = 0, alpha = 1, rot = 0, rot_x = 0, rot_y = 0, color = 0xffffffff)
    super(width, height, scale_x, scale_y, xport, yport, x, y, alpha, rot, rot_x, rot_y, color)
    @follow = nil 
  end

  def update
    if @follow 
      @x = @follow.x - @width/2/@scale_x
      @y = @follow.y - @height/2/@scale_y
      puts "#{@x}.#{@y})"
    end 
  end

end
