require 'gosu'

class InputManager

  def initialze(mappings = {})
    @mappings = mappings
    @publishers = []
  end

  def add_publisher(publisher)
    @publishers << publisher
  end

  def remove_publisher(publisher)
    @publishers.remove*publisher)
  end

  def update(id)
    if @mappings[id]
      message = Message.new(self, type: "button_pressed", key: @mappings[id])
      @publishers.each { |publisher| publisher.publish(message) }
    end
  end
end
