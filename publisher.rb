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
    @subsribers.delete(subscriber)
  end

  def publish(message)
    @subscribers.each { |subscriber| subscriber.receive }
  end
end
