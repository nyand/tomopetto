require_relative 'camera'

class FollowCamera < Camera

  attr_accessor :follow
  def initialize(height, scale_x = 1, scale_y = 1, x = 0, y = 0, alpha = 1, rot = 0, rot_x = 0, rot_y = 0, color = 0xffffffff)
    super(height, scale_x, scale_y, x, y, alpha, rot, rot_x, rot_y, color)
    @follow = nil 
  end

  def update
    if @follow
      @x = @follow.x + 50 
      @y = @follow.y + 50
      puts "#{@x}.#{@y})"
    end 
  end
end
