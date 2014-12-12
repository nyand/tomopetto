require_relative 'state'
require_relative 'state_machine'
require_relative 'transition'
require_relative 'dog'

dog = Dog.new

fsm = StateMachine.create :fsm, :idle, :hungry, :eat

tran = { :idle => :hungry }
fsm.define_enter(:idle) { |dog| puts "Enter: Dog is sitting around.." } 
fsm.define_transition(tran, dog, lambda{ |dog| dog.hunger < 90}, lambda{ |dog| puts "Tran: gah hungry!" })
#fsm.define_transition({:hungry => :idle}, dog, lambda{ |dog| dog.hunger >= 90 }, lambda { |dog| puts "Tran: Dog is full now" } )
fsm.define_transition({:hungry => :idle}, dog, lambda{ |dog| dog.hunger < 90 }, lambda{ |dog| puts "Tran: appetite gone with #{dog.hunger}";dog.hunger+= 10 })

fsm.begin
dog.hunger = 50

15.times do 
  fsm.transition
end
