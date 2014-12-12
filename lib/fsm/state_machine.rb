class StateMachine

  attr_accessor :name
  attr_reader :state_name

  def initialize(name, initial_state)
    @name = name
    @current_state = initial_state
    @state_name = @current_state.name
    @previous_states = []
    @states = {@state_name => @current_state}
  end

  def add_state(state)
    @states[state.name] = state 
  end

  def add_transition(transition)
    @states[transition.from].add_transition(transition)
  end

  def transition
    if @current_state.next_state.count > 0
      @previous_states << @current_state
      @current_state = @states[@current_state.next_state.first]
      @state_name = @current_state.name
    end
  end

  def history
    @previous_states.map { |state| state.name }
  end
end
