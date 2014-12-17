require_relative 'component'

class Position < Component

  attr_reader :x, :y

  def initialize(x,y)
    @x = x
    @y = y
  end

  def update
    payload = {type: "position_updated", x: @x, y: @y}
    @publisher.publish(payload)
  end

  def receive_message(message)
    payload = message.payload
    #puts "Got payload: #{payload}" if payload[:type] == "position_move"
    if payload[:type] == "position_move"
      @x += payload[:x]
      @y += payload[:y]
      #puts "Updated position #{@x},#{@y}"
    end  
  end
end
