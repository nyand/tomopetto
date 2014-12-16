require 'gosu'
require_relative 'message'
class InputManager

  def initialize(mappings = {})
    @mappings = mappings
    @publishers = []
  end

  def add_publisher(publisher)
    @publishers << publisher
  end

  def remove_publisher(publisher)
    @publishers.remove(publisher)
  end

  def update(id)
    if @mappings[id]
      payload = {type: "button_pressed", key: @mappings[id]}
      @publishers.each { |publisher| publisher.publish(payload) }
    end
  end
end
