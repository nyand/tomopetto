class Camera

  attr_accessor :scale_x, :scale_y, :x, :y, :alpha, :rot, :rot_x, :rot_y
  def initialize(height, scale_x = 1, scale_y = 1, x = 0, y = 0, alpha = 1, rot = 0, rot_x = 0, rot_y = 0)
    @objects = []
    @scale_x = scale_x
    @scale_y = scale_y
    @x = x
    @y = y
    @alpha = alpha
    @rot = rot 
    @rot_x = rot_x
    @rot_y = rot_y
    @height = height
  end

  def add(object)
    @objects << object
  end

  def remove(object)
    @objects.remove(object)
  end

  def draw
    @objects.each do |object|
      image = object.image
      x = @scale_x*(object.x - @x) - rot_x 
      y = @scale_y*(object.y - @y) - rot_y 
      rad_rot = @rot * Math::PI / 180
      new_x = x*Math.cos(rad_rot) - y*Math.sin(rad_rot) + rot_x
      new_y = x*Math.sin(rad_rot) + y*Math.cos(rad_rot) + rot_y
      image.draw_rot(new_x, new_y, @height*object.z*2 + object.y, @rot, 0.5, 0.5, scale_x, scale_y)
    end
  end
end
