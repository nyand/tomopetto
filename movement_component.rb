require_relative 'component'

class MovementComponent < Component

  def initialize
    @x = @y = 0
  end

  def update
    payload = {type: "position_move", x: @x, y: @y}
    publisher.publish(payload)    
    @x =  @y = 0 
  end

  def receive_message(message)
    payload = message.payload
    if payload[:type] == :pressing 
      if payload[:key] == "left"
        @x = -1
      elsif payload[:key] == "right"
        @x = 1
      elsif payload[:key] == "up"
        @y = -1
      elsif payload[:key] == "down"
        @y = 1
      end
    end
  end
end
