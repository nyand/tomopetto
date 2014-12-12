class State

  attr_reader :name

  attr_accessor :context, :leave_code, :enter_code
  def initialize(name, context = nil, leave = nil, enter = nil)
    @name = name
    @transitions = {}
    @context = context
    @leave_code = leave
    @enter_code = enter
  end

  def add_transition(transition)
    @transitions[transition.name] = transition
  end

  def next_state 
    puts @transitions.count
    transitions = @transitions.values.select { |transition| transition.can_transition? }
    transitions.map { |transition| transition.to }
  end

  def next_state_transition
    @transitions.values.select { |transition| transition.can_transition? }
  end

  def leave
    @leave_code.call(@context) if @leave_code
  end

  def enter
    @enter_code.call(@context) if @enter_code
  end

end
