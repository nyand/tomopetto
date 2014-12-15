class Transition

  attr_reader :from, :to, :name
  attr_accessor :guard_context, :execute_context, :guard_code, :execute_code  
  def initialize(name, from, to, guard_context, execute_context, guard, execute_code)
    @name = name
    @from = from
    @to = to
    @guard_context = guard_context
    @execute_context = execute_context
    @guard_code = guard
    @execute_code = execute_code
  end

  def can_transition?
    #@guard.call(@context) unless !@guard
    if @guard_code
      @guard_code.call(@guard_context)
    else
      true
    end
  end

  def execute
    @execute_code.call(@execute_context) if @execute_code
  end

end
