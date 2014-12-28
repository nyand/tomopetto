class PhysicsManager

  def initialize
    @bodies = []
    @collision_checker = Publisher.new("Physics")
    @collision_resolver = Publisher.new("Collision Resolver")
  end

  def add(body)
    @bodies << body
    @collision_checker.subscribe(body)
    @collision_resolver.subscribe(body.owner)
  end

  def remove(body)
    @bodies.remove(body)
    @collision_checker.unsubscribe(body)
    @collision_resolver.unsubscribe(body.owner)
  end

  def receive_message(message)

  end

  def update
    @bodies.each do |body1|
      @bodies.each do |body2|
        if !body1.equal?(body2) && aabb_collision?(body1, body2)
          payload = {type: "position_reset"} 
          @collision_resolver.publish(payload, [body1.owner, body2.owner])
        end
      end
    end
  end

  def aabb_collision?(object1, object2)
    !((object1.x + object1.width) < object2.x || object1.x > (object2.x + object2.width) || object1.y > (object2.y + object2.height) || (object1.y + object1.height) < object2.y)
  end
end
