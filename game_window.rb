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
class GameWindow < Gosu::Window
    def initialize
      super 320,240, false
      self.caption = "友ペット - Tomopetto"

      @image_manager = ImageManager.new(self)
      @image_manager.load("chaos.png", 21, 25)

      @input_manager = InputManager.new(Gosu::KbLeft => 'left', Gosu::KbRight => 'right',
                                        Gosu::KbUp => 'up', Gosu::KbDown => 'down')
      @keyboard_publisher = Publisher.new('Keyboard')
      @input_manager.add_publisher(@keyboard_publisher)
      #@pet = Pet.new("Chaos")
      #@keyboard_publisher.subscribe(@pet)
      @count = 0

      @manager = GameObjectManager.new

      @pet = DrawableGameObject.new(1, Publisher.new('Pet'))
      position = Position.new(20,20)
      @pet.add_component(position)
      draw = DrawComponent.new(@image_manager.get("chaos.png")[1])
      @pet.add_component(draw)
      movement = MovementComponent.new
      @pet.add_component(movement)

      @pet2 = DrawableGameObject.new(1, Publisher.new('Pet2'))
      position = Position.new(50, 50)
      @pet2.add_component(position)
      movement = MovementComponent.new
      @pet2.add_component(movement)
      draw = DrawComponent.new(@image_manager.get("chaos.png")[0])
      @pet2.add_component(draw)
      @keyboard_publisher.subscribe(@pet2)

      @manager.add(@pet)
      @manager.add(@pet2)
      
    end

    def update
      @manager.update
      @count += 1
      @count = 0 if @count == 150 
      if button_down?(Gosu::KbLeft)
        @input_manager.update(Gosu::KbLeft)
      end

      if button_down?(Gosu::KbRight)
        @input_manager.update(Gosu::KbRight)
      end
      
      if button_down?(Gosu::KbUp)
        @input_manager.update(Gosu::KbUp)
      end

      if button_down?(Gosu::KbDown)
        @input_manager.update(Gosu::KbDown)
      end

    end

    def draw
      @manager.draw
      #@image_manager.get("chaos.png")[@count/30].draw(@pet.x,@pet.y, 0)
    end

end

window = GameWindow.new
window.show
