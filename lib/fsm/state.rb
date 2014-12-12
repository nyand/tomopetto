class State

  attr_reader :name

  def initialize(name, context = nil, leave = nil, enter = nil)
    @name = name
    @transitions = {}
    @context = context
    @leave = leave
    @enter = enter
  end

  def add_transition(transition)
    @transitions[transition.name] = transition
  end

  def next_state 
    transitions = @transitions.values.select { |transition| transition.can_transition? }
    transitions.map { |transition| transition.to }
  end

  def leave
    @leave.call(@context) if leave
  end

  def enter
    @enter.call(@context) if enter
  end

end
