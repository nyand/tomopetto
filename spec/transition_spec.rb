require 'spec_helper'

describe Transition do

  describe "#new" do
    it "returns a new Transition object" do
      transition = Transition.new(:start_to_end, :start, :end, nil, nil, nil)
      expect(transition).to be_a Transition
    end
  end

  describe "#can_transition?" do
    it "will run the guard when a guard is defined" do
      guard = Proc.new { true }
      transition = Transition.new(:start_to_end, :start, :end, nil, guard, nil)
      expect(transition.can_transition?).to eq true
    end
    
    it "will return the value of the executed guard" do
      true_guard = Proc.new { true }
      transition = Transition.new(:start_to_end, :start, :end, nil, true_guard, nil)
      expect(transition.can_transition?).to eq true
      
      false_guard = Proc.new { false }
      transition = Transition.new(:start_to_end, :start, :end, nil, false_guard, nil)
      expect(transition.can_transition?).to eq false
    end

    it "will return true is guard is not defined" do
      transition = Transition.new(:start_to_end, :start, :end, nil, nil, nil)
      expect(transition.can_transition?).to eq true
    end
  end

  describe "#execute" do
    it "executes the execute code if it is defined" do
      execute = Proc.new { 5 }
      transition = Transition.new(:start_to_end, :start, :end, nil, nil, execute)
      expect(transition.execute).to eq 5 
    end

    it "does not execute the execute code if it is not defined" do
      transition = Transition.new(:start_to_end, :start, :end, nil, nil, nil)
      expect(transition.execute).to eq nil
    end 
  end
end 
