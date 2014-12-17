require_relative 'component'
require 'gosu'

class DrawComponent < Component

  def initialize(image)
    @image = image
    puts @image
    @x = 0
    @y = 0
    @z = 0
  end

  def draw
    @image.draw(@x,@y,@y)
  end

  def receive_message(message)
    payload = message.payload
    
    if payload[:type] == "position_updated"
      @x = payload[:x]
      @y = payload[:y]
    end
  end
end
