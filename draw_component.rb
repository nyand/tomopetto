require_relative 'component'
require 'gosu'

class DrawComponent < Component

  attr_reader :image, :x, :y, :z, :alpha
  def initialize(image, z = 0)
    @image = image
    @x = 0
    @y = 0
    @z = z 
    @alpha = 1.0
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
