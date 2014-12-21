require 'gosu'
require_relative 'lib/messaging/message'

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


  def update(id, type)
    if @mappings[id]
      payload = {type: type, key: @mappings[id]}
      @publishers.each { |publisher| publisher.publish(payload) }
    end
  end
end
