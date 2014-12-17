class GameObject

  attr_reader :id, :components
  def initialize(id, publisher)
    @id = id
    @publisher = publisher 
    @components = []
  end

  def add_component(component)
    @components << component
    @publisher.subscribe(component)
    component.publisher = @publisher
  end

  def remove_component(component)
    @components.remove(component)
    @publisher.unsubscribe(component)
  end

  def update
    @components.each { |component| component.update } 
  end

  def receive_message(message)
    @components.each { |component| component.receive_message(message) }
  end
end
