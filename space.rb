class Space

  attr_reader :updaters, :cameras, :running
  def initialize(running, updaters = [], cameras = [])
    @running = running
    @updaters = updaters
    @cameras = cameras
  end

  def update
    @updaters.each { |updater| updater.update } if @running
  end

  def draw
    @cameras.each do |camera| 
      @window.clip_to(camera.xport, camera.yport, camera.width, camera.height) do
        camera.draw
      end if running
    end
  end
end
