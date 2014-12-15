require_relative 'state_machine'
require_relative 'dog'

dog = Dog.new
dog.hunger = 50 
fsm = StateMachine.create :fsm, :idle, :hungry, :eat

fsm.set :transition, { :idle => :hungry, :hungry => :eat, :eat => :hungry, :eat => :idle }

fsm.set :guard, { :idle => :hungry }, dog do |dog|
  dog.hunger < 90
  true
end

fsm.set :guard, { :hungry => :eat }, dog do |dog|
  dog.hunger < 90
  true
end

fsm.set :guard, { :eat => :hungry }, dog do |dog|
  dog.hunger < 90
  true
end

fsm.set :guard, { :eat => :idle }, dog do |dog|
  dog.hunger >= 90
end

fsm.set :execute, { :idle => :hungry }, dog do |dog|
  puts "idle => hungry : Dog is hungry!"
end

fsm.set :execute, { :hungry => :eat }, dog do |dog|
  puts "hungry => eat : Dog is eating"
end

fsm.set :execute, { :eat => :idle }, dog do |dog|
  puts "eat => idle : Dog is full : #{dog.hunger} "
end

fsm.set :execute, { :eat => :hungry }, dog do |dog|
  puts "eat => hungry Dog is still hungry"
end

fsm.set :enter, :idle, dog do |dog|
  puts "Dog is wiggling its butt"
end

fsm.set :enter, :eat, dog do |dog|
  dog.hunger += 10
  puts "Yum yum : #{dog.hunger}"
end

15.times { fsm.transition }
