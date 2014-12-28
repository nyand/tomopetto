require_relative 'scene'
require_relative 'game_object_factory'
require_relative 'image_manager'

class GameScene < Scene

  def start
    factory = GameObjectFactory.new(@spaces[:update])
    image_manager = ImageManager.new(@window)
    image_manager.load("chaos.png", 21, 25)
    space = @spaces[:update]    
    camera = Camera.new(320,240,1,1,0,0)
    space.updaters << camera
    space.updaters << GameObjectManager.new

    input_manager = InputManager.new(Gosu::KbLeft => 'left', Gosu::KbRight => 'right',
                                        Gosu::KbUp => 'up', Gosu::KbDown => 'down')
    space.updaters << KeyboardManager.new(input_manager)
    space.updaters << PhysicsManager.new
    space.cameras << camera

    factory.create(DrawableGameObject, "Pet", [PositionComponent.new(50,50, true), 
                                               MovementComponent.new,
                                               DrawComponent.new(image_manager.get("chaos.png")[0], 1),
                                               RectangleComponent.new(nil, 50, 50, 20, 20)])


  end
end
