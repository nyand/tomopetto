class Pet

  attr_reader :name, :x, :y
  def initialize(name)
    @name = name
    @x = 50
    @y = 50
  end

  def receive_message(message)
    payload = message.payload 
    if payload[:type] == "button_pressed"
      if payload[:key] == "left"
        @x -= 1 
      end
      if payload[:key] == "right"
        @x += 1
      end
      if payload[:key] == "up"
        @y -= 1
      end
      if payload[:key] == "down"
        @y += 1
      end
    end
  end
end
