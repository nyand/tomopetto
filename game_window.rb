require 'gosu'
require_relative 'image_manager'
require_relative 'pet'
require_relative 'input_manager'
require_relative 'lib/messaging/publisher'
require_relative 'game_object'
require_relative 'component'
require_relative 'position'
require_relative 'movement_component'
require_relative 'draw_component'
require_relative 'drawable_game_object'
require_relative 'game_object_manager'
require_relative 'keyboard_manager'
require_relative 'mouse_manager'

class GameWindow < Gosu::Window
    def initialize
      super 320,240, false
      self.caption = "友ペット - Tomopetto"

      @image_manager = ImageManager.new(self)
      @image_manager.load("chaos.png", 21, 25)
      @image_manager.load("hand.png")
      
      @input_manager = InputManager.new(Gosu::KbLeft => 'left', Gosu::KbRight => 'right',
                                        Gosu::KbUp => 'up', Gosu::KbDown => 'down')

      @keyboard_publisher = Publisher.new('Keyboard')
      @input_manager.add_publisher(@keyboard_publisher)

      @manager = GameObjectManager.new

      @pet = DrawableGameObject.new(1, Publisher.new('Pet'))
      position = Position.new(20,20)
      @pet.add_component(position)
      draw = DrawComponent.new(@image_manager.get("chaos.png")[1],self.height)
      @pet.add_component(draw)
      movement = MovementComponent.new
      @pet.add_component(movement)

      @pet2 = DrawableGameObject.new(1, Publisher.new('Pet2'))
      position = Position.new(50, 50)
      @pet2.add_component(position)
      movement = MovementComponent.new
      @pet2.add_component(movement)
      draw = DrawComponent.new(@image_manager.get("chaos.png")[0], self.height)
      @pet2.add_component(draw)
      @keyboard_publisher.subscribe(@pet2)

      @cursor = DrawableGameObject.new(1, Publisher.new('Cursor'))
      position = Position.new(100,100)
      @cursor.add_component(position)
      movement = MovementComponent.new
      @cursor.add_component(movement) 
      draw = DrawComponent.new(@image_manager.get("hand.png"), self.height, 1)
      @cursor.add_component(draw)
      @keyboard_publisher.subscribe(@cursor)

      @manager.add(@pet)
      @manager.add(@pet2)
      @manager.add(@cursor)
      
      @keyboard_manager = KeyboardManager.new(@input_manager)
      @mouse_manager = MouseManager.new
    end

    def update
      @mouse_manager.update(self.mouse_x, self.mouse_y)
      @keyboard_manager.update
      @manager.update
    end

    def draw
      @manager.draw
    end

    def button_down(id)
      @keyboard_manager.button_pressed(id)
    end

    def button_up(id)
      @keyboard_manager.button_released(id)
    end

end

window = GameWindow.new
window.show
