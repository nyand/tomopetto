class GameObjectManager

  def initialize
    @game_objects = []
  end

  def add(object, priority = 0)
    if !has_object(object)
      @game_objects << {object: object, priority: priority} 
      @game_objects.sort! { |o1, o2| o1[:priority] <=> o2[:priority] }
    end
  end

  def has_object(object)
    objects = @game_objects.select { |hash| hash[:object] == object }
    objects.count > 0
  end

  def remove(object)
    game_objects.remove(object)
  end

  def update
    @game_objects.each { |hash| hash[:object].update }
  end

  def draw
    @game_objects.each { |hash| hash[:object].draw if hash[:object].respond_to?(:draw) }
  end
    
end
