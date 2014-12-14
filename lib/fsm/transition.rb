class Transition

  attr_reader :from, :to, :name
  
  def initialize(name, from, to, context, guard, execute_code)
    @name = name
    @from = from
    @to = to
    @context = context
    @guard = guard
    @execute_code = execute_code
  end

  def can_transition?
    #@guard.call(@context) unless !@guard
    if @guard
      @guard.call(@context)
    else
      true
    end
  end

  def execute
    @execute_code.call(@context) if @execute_code
  end

end
