require_relative 'space'
class Scene
  
  attr_reader :name
  def initialize(name, window, publisher, updaters = [], cameras = [] )
    @name = name
    @window = window
    @publisher = publisher
    @publisher.subscribe(self)

    @space = Space.new(true, updaters, cameras)
  end

  def start
    #load objects etc
  end

  def end
    #clean up
  end

  def update
    @space.update
  end

  def draw
    @space.draw
  end

  def transition

  end

  def receive_message(message)

  end

end
