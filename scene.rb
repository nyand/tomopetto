require_relative 'space'
class Scene
  
  attr_reader :name
  def initialize(name, window, publisher, updaters = [], cameras = [] )
    @name = name
    @window = window
    @publisher = publisher
    @publisher.subscribe(self)

    @spaces = {update:  Space.new(true, window, updaters, cameras)}
  end

  def start
    #load objects etc
  end

  def end
    #clean up
  end

  def update
    @spaces[:update].update
  end

  def draw
    @spaces[:update].draw
  end

  def transition

  end

  def receive_message(message)

  end

end
