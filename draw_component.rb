require_relative 'component'
require 'gosu'

class DrawComponent < Component

  def initialize(image)
    @image = image
    puts @image
    @x = 0
    @y = 0
  end

  def draw
    @image.draw(@x,@y,0)
  end

  def receive_message(message)
    payload = message.payload
    puts "Draw: got payload #{payload}"
    
    if payload[:type] == "position_updated"
      puts "Draw: received payload #{payload}"
      @x = payload[:x]
      @y = payload[:y]
    end
  end
end
