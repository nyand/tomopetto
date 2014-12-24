require_relative 'component'

class Position < Component

  attr_reader :x, :y

  def initialize(x,y, debug = false)
    @x = @prev_x = x
    @y = @prev_y = y
    @debug = debug
  end

  def update
    payload = {type: "position_updated", x: @x, y: @y}
    @publisher.publish(payload)
  end

  def receive_message(message)
    payload = message.payload
    #puts "Got payload: #{payload}" if payload[:type] == "position_move"
    if payload[:type] == "position_move"
      @prev_x = @x
      @prev_y = @y
      @x += payload[:x]
      @y += payload[:y]
      if @debug
        puts ""
        puts "Updated position #{@x},#{@y}"
        puts "Previousposition #{@prev_x},#{@prev_y}"
        puts ""
      end
    end  

    if payload[:type] == "position_reset"
      @x = payload[:x] || @prev_x
      @y = payload[:y] || @prev_y
      puts "Reset"
    end
  end
end
