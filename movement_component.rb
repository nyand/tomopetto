require_relative 'component'

class MovementComponent < Component

  def receive_message(message)
    payload = message.payload
    if payload[:type] == "button_pressed"
      if payload[:key] == "left"
        payload = {type: "position_move", x: -1, y: 0}
      end
      if payload[:key] == "right"
        payload = {type: "position_move", x: 1, y: 0}
      end
      if payload[:key] == "up"
        payload = {type: "position_move", x: 0, y: -1}
      end
      if payload[:key] == "down"
        payload = {type: "position_move", x: 0, y: 1}
      end
      publisher.publish(payload)
    end
  end
end
