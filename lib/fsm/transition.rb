class Transition

  attr_reader :from, :to, :name
  
  def initialize(name, from, to, context, guard, execute)
    @name = name
    @from = from
    @to = to
    @context = context
    @guard = guard
    @execute = execute
  end

  def can_transition?
    @guard.call(@context)
  end

end
