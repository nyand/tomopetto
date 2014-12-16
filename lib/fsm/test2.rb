require_relative 'state'
require_relative 'state_machine'
require_relative 'transition'
require_relative 'dog'

dog = Dog.new

fsm = StateMachine.create :fsm, :idle, :hungry, :eat

fsm.define_transition({:idle=>:hungry}, dog, lambda{|dog| dog.hunger < 90 }, lambda{|dog| puts "Hungry" })
fsm.define_transition({:hungry=>:eat}, dog, lambda{|dog| true }, lambda{|dog| puts "Eating" })
fsm.define_enter(:eat) {|dog| dog.hunger += 10}
fsm.define_transition({:eat=>:hungry}, dog, lambda{|dog| dog.hunger < 90 }, lambda { |dog| puts "Still hungry" })
fsm.define_transition({:eat=>:idle}, dog, lambda{|dog| dog.hunger >= 90 }, lambda{ |dog| puts "Full"})
fsm.define_enter(:idle) {|dog| puts "Wiggling butt"}

10.times do
  fsm.transition
  dog.hunger -= 5
end
