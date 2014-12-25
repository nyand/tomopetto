class Camera

  attr_accessor :scale_x, :scale_y, :x, :y, :xport, :yport, :alpha, :rot, :rot_x, :rot_y, :color, :width, :height
  def initialize(width, height, scale_x = 1, scale_y = 1, xport = 0, yport = 0, x = 0, y = 0, alpha = 1, rot = 0, rot_x = 0, rot_y = 0, color = 0xffffffff)
    @objects = []
    @scale_x = scale_x  
    @scale_y = scale_y
    @x = x
    @y = y
    @xport = xport
    @yport = yport
    @alpha = alpha
    @rot = rot 
    @rot_x = rot_x
    @rot_y = rot_y
    @color = color
    @width  = width
    @height = height
  end

  def add(object)
    @objects << object
  end

  def remove(object)
    @objects.remove(object)
  end

  def update
  end

  def draw
    @objects.each do |object|
      image = object.image
      x = (object.x - @x) - @rot_x 
      y = (object.y - @y) - @rot_y 
      new_x = rotate_x(x,y,@rot) + @rot_x
      new_y = rotate_y(x,y,@rot) + @rot_y
      
      image.draw_rot(@scale_x*new_x+@xport, @scale_y*new_y+@yport, @height*object.z*2 + object.y, @rot, 0.5, 0.5, scale_x, scale_y,color) 
    end

  end

    def rotate_x(x, y, angle)
      rad_rot = angle * Math::PI / 180
      x*Math.cos(rad_rot) - y*Math.sin(rad_rot)
    end

    def  rotate_y(x,y, angle)
      rad_rot = angle * Math::PI / 180
      x*Math.sin(rad_rot) + y*Math.cos(rad_rot)
    end
end
