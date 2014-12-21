class MouseManager
  
  def initialize
    @x = 0
    @y = 0
  end

  def update(x, y)
    if @x != x || @y != y 
      puts "Mouse: (#{x},#{y})"
    end

    @x = x
    @y = y
  end
end
