require_relative 'state'
require_relative 'transition'

class StateMachine

  attr_accessor :name
  attr_reader :state_name

  def initialize(name, initial_state)
    @name = name
    @current_state = initial_state
    @state_name = @current_state.name
    @previous_states = []
    @states = {@state_name => @current_state}
    @current_state.enter
  end

  def add_state(state)
    @states[state.name] = state if state
  end

  def add_transition(transition)
    if transition && @states[transition.from] && @states[transition.to]
      @states[transition.from].add_transition(transition) 
    end
  end

  def transition
    if @current_state.next_state.count > 0
      @previous_states << @current_state
      next_state = @states[@current_state.next_state.first]
      @current_state.leave
      @current_state.next_state_transition.first.execute 
      @current_state = next_state
      @current_state.enter
      @state_name = @current_state.name
    else
      @previous_states << @current_state
      @current_state.default
    end
  end

  def history
    @previous_states.map { |state| state.name }
  end

  def has_state(state_name)
    !@states[state_name].nil?
  end

  # DSL Helper methods
  def self.create(name, initial_state_name, *state_names)
    raise "No initial state" if !initial_state_name
    
    state_names.unshift(initial_state_name)
    states = state_names.map do |name|
      State.new(name) 
    end
    
    state_machine = StateMachine.new(name, states.shift)

    states.each { |state| state_machine.add_state(state) }

    state_machine
  end 

  def begin
    @current_state.enter
  end

  def set(event, state, context = nil, &block)
    if event == :enter
      define_enter(state, context, &block)
    elsif event == :leave
      define_leave(state, context, &block)
    elsif event == :guard
      define_guard(state, context, &block)
    elsif event == :execute
      define_execute(state, context, &block)
    elsif event == :default
      define_default(state, context, &block)
    elsif event == :transition && state.is_a?(Array) 
      state.each { |value| define_transition(value) }
    end
  end

  def define_enter(state, context = nil, &block)
    @states[state].enter_code = block if @states[state]
    @states[state].enter_context = context if @states[state]
  end

  def define_leave(state, context = nil, &block)
    @states[state].leave_code = block if @states[state]
    @states[state].leave_context = context if @states[state]
  end

  def define_default(state, context = nil, &block)
    @states[state].default_code = block if @states[state]
    @states[state].default_context = context if @states[state]
  end

  def define_guard(to_from, context = nil, &block)
    to = to_from.values.first
    from = to_from.keys.first
    name = to.to_s.concat("_").concat(from.to_s).to_sym
    if @states[to] && @states[from]
      transition = @states[from].transitions[name]
      if transition
        transition.guard_code = block
        transition.guard_context = context unless context == nil
      end
    end

  def define_execute(to_from, context = nil, &block)
    to = to_from.values.first
    from = to_from.keys.first
    name = to.to_s.concat("_").concat(from.to_s).to_sym
    if @states[to] && @states[from]
      transition = @states[from].transitions[name]
      if transition
        transition.execute_code = block
        transition.execute_context = context unless context == nil
      end
    end
  end

 end

  def define_transition(from_to, guard_context = nil, execute_context = nil, guard = nil, execute = nil) 
    to = from_to.values.first
    from = from_to.keys.first
    if @states[to] && @states[from]
      name = to.to_s.concat("_").concat(from.to_s).to_sym
      transition = Transition.new(name, from, to, guard_context, execute_context, guard, execute)
      add_transition(transition)
    end 
  end
end
