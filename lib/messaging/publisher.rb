require_relative 'message'
class Publisher

  attr_reader :name
  def initialize(name)
    @name = name 
    @subscribers = []
  end

  def subscribe(subscriber)
    @subscribers << subscriber
  end

  def unsubscribe(subscriber)
    @subscribers.delete(subscriber)
  end

  def publish(payload, to = @subscribers)
    message = Message.new(self, payload)
    #puts "Received filtered: #{@name}" unless to.equal?(@subscribers)
    to.each { |subscriber| subscriber.receive_message(message) }
  end
end
