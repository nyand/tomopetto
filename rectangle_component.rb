class RectangleComponent < Component

  attr_reader :x, :y, :width, :height

  def initialize(x, y, width, height)
    @x = x
    @y = y
    @width = width
    @height = height
  end

  def update

  end

  def receive_message(message)
    if payload[:type] == "position_updated"
      @x = payload[:x]
      @y = [payload[:y]
    end

    if payload[:type] == "collision_check"
      #deal and handle collisions here
      object = payload[:object]
      self.aabb_collision(self, object)
    end

  end

  def self.aabb_collision?(object1, object2)
    (object1.width < object2.x || object1.x > object2.width) && (object1.y > object2.height || object1.height < object2.y)
  end
end
