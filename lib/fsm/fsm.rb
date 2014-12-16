require_relative 'state_machine'
require_relative 'dog'

dog = Dog.new
fsm = StateMachine.create :fsm, :idle, :hungry, :eat, :sleep, :run

fsm.set :transition, [{:run => :idle}, {:idle => :hungry}, {:hungry => :eat}, {:eat => :idle}, {:eat => :hungry}, ]

fsm.set :guard, { :idle => :hungry }, dog do |dog|
  dog.hunger < 90
end

fsm.set :guard, { :idle => :run }, dog do |dog|
  dog.hunger >= 90
end

fsm.set :default, :idle, dog do |dog|
  puts "Bored..."
end

fsm.set :execute, { :idle => :run}, dog do |dog|
  puts "Woof Woof. Dog is running"
end

fsm.set :guard, { :run => :idle }, dog do |dog|
  true
end

fsm.set :guard, { :hungry => :eat }, dog do |dog|
  dog.hunger < 90
end

fsm.set :guard, { :eat => :hungry }, dog do |dog|
  dog.hunger < 90
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
  puts "Dog is wiggling its butt #{dog.hunger}"
end

fsm.set :enter, :eat, dog do |dog|
  dog.hunger += 10
  puts "Yum yum : #{dog.hunger}"
end

20.times { fsm.transition }
