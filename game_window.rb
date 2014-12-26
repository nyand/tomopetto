require 'gosu'
require_relative 'image_manager'
require_relative 'pet'
require_relative 'input_manager'
require_relative 'lib/messaging/publisher'
require_relative 'game_object'
require_relative 'component'
require_relative 'position_component'
require_relative 'movement_component'
require_relative 'draw_component'
require_relative 'drawable_game_object'
require_relative 'game_object_manager'
require_relative 'keyboard_manager'
require_relative 'mouse_manager'
require_relative 'physics_manager'
require_relative 'rectangle_component'
require_relative 'follow_camera.rb'
class GameWindow < Gosu::Window
    def initialize
      super 320,240, false
      self.caption = "友ペット - Tomopetto"

      @image_manager = ImageManager.new(self)
      @image_manager.load("chaos.png", 21, 25)
      @image_manager.load("hand.png")
      @image_manager.load("block.png")
      @image_manager.load("grass.png")
      @camera = Camera.new(320,240, 1, 1, 0, 0)
      @input_manager = InputManager.new(Gosu::KbLeft => 'left', Gosu::KbRight => 'right',
                                        Gosu::KbUp => 'up', Gosu::KbDown => 'down')

      @keyboard_publisher = Publisher.new('Keyboard')
      @input_manager.add_publisher(@keyboard_publisher)

      @manager = GameObjectManager.new
      
      @collision = PhysicsManager.new

      @pet2 = DrawableGameObject.new(1, Publisher.new('Pet2'))
      position = PositionComponent.new(50, 50, true)
      @pet2.add_component(position)
      movement = MovementComponent.new
      @pet2.add_component(movement)
      draw = DrawComponent.new(@image_manager.get("chaos.png")[0], 1)
      @pet2.add_component(draw)
      @keyboard_publisher.subscribe(@pet2)
      collision = RectangleComponent.new(@pet2, 50, 50,20,20)
      @pet2.add_component(collision)
      @collision.add(collision)
      @camera.add(draw)

      @cursor = DrawableGameObject.new(1, Publisher.new('Cursor'))
      position = PositionComponent.new(100,100)
      @cursor.add_component(position)
      movement = MovementComponent.new
      @cursor.add_component(movement) 
      draw = DrawComponent.new(@image_manager.get("hand.png"), 2)
      @cursor.add_component(draw)
      @keyboard_publisher.subscribe(@cursor)
      @camera.add(draw)

      20.times do |y|
        #top
        block = DrawableGameObject.new(y, Publisher.new)
        position = PositionComponent.new(8,y*16+8)
        block.add_component(position)
        collision = RectangleComponent.new(block, position.x, position.y, 16,16)
        block.add_component(collision)
        @collision.add(collision)
        draw = DrawComponent.new(@image_manager.get("block.png"), 1)
        block.add_component(draw)
        @manager.add(block)
        @camera.add(draw)

        #left
        block = DrawableGameObject.new(y+16, Publisher.new)
        position = PositionComponent.new(y*16+8,8)
        block.add_component(position)
        collision = RectangleComponent.new(block, position.x, position.y, 16,16)
        block.add_component(collision)
        @collision.add(collision)
        draw = DrawComponent.new(@image_manager.get("block.png"), 1)
        block.add_component(draw)
        @manager.add(block)
        @camera.add(draw)

        #bottom
        block = DrawableGameObject.new(y+16*2, Publisher.new)
        position = PositionComponent.new(y*16+8,240-8)
        block.add_component(position)
        collision = RectangleComponent.new(block, position.x, position.y, 16,16)
        block.add_component(collision)
        @collision.add(collision)
        draw = DrawComponent.new(@image_manager.get("block.png"), 1)
        block.add_component(draw)
        @manager.add(block)
        @camera.add(draw)

        #right
        block = DrawableGameObject.new(y+16*2, Publisher.new)
        position = PositionComponent.new(312,y*16+8)
        block.add_component(position)
        collision = RectangleComponent.new(block, position.x, position.y, 16,16)
        block.add_component(collision)
        @collision.add(collision)
        draw = DrawComponent.new(@image_manager.get("block.png"), 1)
        block.add_component(draw)
        @manager.add(block)
        @camera.add(draw)
      end

      20.times do |x|
        15.times do |y|
          grass = DrawableGameObject.new(50, Publisher.new)
          position = PositionComponent.new(x*16+8,y*16+8)
          grass.add_component(position)
          draw = DrawComponent.new(@image_manager.get("grass.png"), 0)
          grass.add_component(draw)
          @manager.add(grass)
          @camera.add(draw)
        end
      end

      @manager.add(@pet2)
      @manager.add(@cursor)
      
      @keyboard_manager = KeyboardManager.new(@input_manager)
      @mouse_manager = MouseManager.new
    end

    def update
      @mouse_manager.update(self.mouse_x, self.mouse_y)
      @keyboard_manager.update
      @manager.update
      @collision.update
      @camera.update
    end

    def draw
      #drawing the camera
      draw_line(@camera.xport+1,@camera.yport+1,0xffffffff,@camera.xport,@camera.height + @camera.yport,0xffffffff)
      draw_line(@camera.xport+1,@camera.yport+1,0xffffffff,@camera.width + @camera.xport,@camera.yport,0xffffffff)
      draw_line(@camera.width + @camera.xport,@camera.yport,0xffffffff,@camera.width + @camera.xport,@camera.height + @camera.yport,0xffffffff)
      draw_line(@camera.xport,@camera.height + @camera.yport,0xffffffff,@camera.width + @camera.xport,@camera.height + @camera.yport,0xffffffff)
      clip_to(@camera.xport, @camera.yport, @camera.width, @camera.height) { @camera.draw }
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
