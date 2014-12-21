class KeyboardManager

  def initialize(input_manager)
    @input_manager = input_manager    
    @buttons_state = {}
  end

  def button_pressed(id)
    @buttons_state[id] = :pressed
  end
  
  def button_released(id)
    @buttons_state[id] = :released
  end

  def update
    pressed = @buttons_state.select { |button, state| state == :pressed }
    released = @buttons_state.select { |button, state| state == :released }
    pressing = @buttons_state.select { |button, state| state == :pressing } 

    @buttons_state.each { |button, state| @input_manager.update(button, state) }
    released.keys.each { |button| @buttons_state.delete(button) }
    pressed.keys.each { |button| @buttons_state[button] = :pressing }
  end
end
