require_relative 'state'
require_relative 'state_machine'
require_relative 'transition'
require_relative 'dog'

dog = Dog.new

fsm = StateMachine.create :fsm, :idle, :hungry, :eat

fsm.set :enter, :idle, dog do |dog|
  puts "Enter: Dog is sitting around.."
end

fsm.set :enter, :idle

tran = { :idle => :hungry }
fsm.define_transition(tran, dog, ->(dog) { dog.hunger < 90}, ->(dog) { puts "Tran: gah hungry!" })

fsm.define_transition({:hungry => :idle}, dog, ->(dog) { dog.hunger >= 90 }, ->(dog) { puts "Tran: Dog is full now" } )
fsm.define_transition({:hungry => :eat}, dog, lambda{ |dog| dog.hunger < 90 }, lambda{ |dog| puts "Tran: Eating  #{dog.hunger}"})
fsm.define_enter(:eat, dog) { |dog| dog.hunger += 10 }
fsm.define_transition({:eat => :hungry}, dog, lambda{ |dog| dog.hunger < 90}, lambda{ |dog| puts "Tran: dog is still hungry #{dog.hunger}"})
fsm.define_transition({:eat => :idle}, dog, lambda{ |dog| dog.hunger >= 90}, lambda{ |dog| puts "Tran: yum yum full"})
fsm.begin
dog.hunger = 50

15.times do 
  fsm.transition
end
