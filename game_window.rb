require 'gosu'
require_relative 'image_manager'
require_relative 'pet'

class GameWindow < Gosu::Window
    def initialize
      super 320,240, false
      self.caption = "友ペット - Tomopetto"

      @image_manager = ImageManager.new(self)
      @image_manager.load("chaos.png", 21, 25)
      @pet = Pet.new("Chaos")
      @count = 0
    end

    def update
      @count += 1
      @count = 0 if @count == 150 
    end

    def draw
      @image_manager.get("chaos.png")[@count/30].draw(@pet.x,@pet.y, 0)
    end

end

window = GameWindow.new
window.show
