require_relative 'scene'
class SceneManager

  attr_reader :scenes, :current, :previous
  def initialize
    @scenes = {}
    @publisher = Publisher.new
  end

  def set_current(scene_name)
    @current = @scenes[scene_name] if @scenes[scene_name]
  end

  def add(scene)
    @scenes[scene.name] = scene
    @publisher.subscribe(scene)
    @current ||= scene
  end

  def remove(scene)
    @scenes.delete(scene.name)
    @publisher.unsubscribe(scene)
  end

  def transition(next_scene)
    next_scene = @scenes[next_scene]
    if next_scene
      @current.end
      @previous = @current
      @current = next_scene
      @current.start
      true
    end
  end

  def start
    @current.start if @current
  end

  def update
    @current.update if @current
  end

  def draw
    @current.draw if @current
  end
end
