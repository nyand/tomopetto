require_relative 'game_object'

class DrawableGameObject < GameObject

  def draw
    @components.each { |component| component.draw if component.respond_to?(:draw) } 
  end
end
