require_relative 'state'
require_relative 'state_machine'
require_relative 'transition'
require_relative 'dog'

dog = Dog.new
hungry = State.new(:hungry)
idle = State.new(:idle)
eat = State.new(:eat, dog, eating)

eating = Proc.new { |dog| dog.hunger += 1 }
eat_to_eat = Transition.new(:eating, :eat, :eat, dog, still_hungry)


guard = Proc.new { |dog| dog.hunger <= 90 }
idle_hungry = Transition.new(:idle_hungry, :idle, :hungry, dog, guard)

fsm = StateMachine.new(:fsm, idle)

fsm.add_state(hungry)
fsm.add_transition(idle_hungry)

puts "Dog State: #{fsm.state_name} "

dog.hunger = 50
puts "Dog getting hungry - #{dog.hunger}"

puts fsm.transition

puts "Dog State: #{fsm.state_name} "
