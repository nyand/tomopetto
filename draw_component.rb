require_relative 'component'
require 'gosu'

class DrawComponent < Component

  def initialize(image, height = 320, z = 0)
    @image = image
    puts @image
    @x = 0
    @y = 0
    @z = z 
    @height = height
  end

  def draw
    @image.draw(@x,@y,@height*@z*2 + @y)
  end

  def receive_message(message)
    payload = message.payload
    
    if payload[:type] == "position_updated"
      @x = payload[:x]
      @y = payload[:y]
    end
  end
end
