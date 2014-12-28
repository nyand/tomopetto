class Scene
  
  attr_reader :updaters, :cameras, :name
  def initialize(name, window, publisher, updaters = [], cameras = [] )
    @name = name
    @window = window
    @updaters = updaters 
    @cameras = cameras
    @publisher = publisher
    @publisher.subscribe(self)
  end

  def start
    #load shit etc
  end

  def end
    #clean up
  end

  def update
    @updaters.each { |updater| updater.update }
  end

  def draw
    @cameras.each do |camera| 
      @window.clip_to(camera.xport, camera.yport, camera.width, camera.height) { camera.draw }
    end
  end

  def transition

  end

  def receive_message(message)

  end

end
