class PhysicsManager

  def initialize
    @bodies = []
    @collision_checker = Publisher.new("Physics")
  end

  def add(body)
    @bodies << body
    @collision_checker.subscribe(body)
  end

  def remove(body)
    @bodies.remove(body)
    @collision_checker.unsubscribe(body)
  end

  def update
    @bodies.each do |body1|
      payload = {type: "collision_check", object: body1}
      @collision_checker.publisher(payload)
    end
  end
end
