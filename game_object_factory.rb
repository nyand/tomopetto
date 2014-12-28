class GameObjectFactory
  
  def initialize(space)
    @next_id = 0
    @space = space
  end  

  def create(object_type, name, components = [])
    object = object_type.new(@next_id, Publisher.new(name))
    components.each do |component| 
      object.add_component(component)
      if component.class == RectangleComponent
        physics_systems = @space.updaters.select { |updater| updater.class == PhysicsManager }  
        physics_systems.each { |system| system.add(component) }
        component.owner = object
      end
      
      if component.class == DrawComponent
        @space.cameras.each { |camera| camera.add(component) } 
      end
    end

    managers = @space.updaters.select { |updater| updater.class == GameObjectManager }

    managers.each { |manager| manager.add(object) }
  
    @next_id += 1
  end
end
