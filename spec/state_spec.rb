require 'spec_helper'

describe State do

  before :each do
    @state = State.new(:init)
  end

  describe "#new" do
    it "takes one parameter and returns a State object" do
      expect(@state).to be_an_instance_of State
    end 

    it "has a name called :init" do
      expect(@state.name).to eq :init
    end
  end

  describe "#add_transition" do
    it "accepts a transition from state" do
      transition = double("transition")
      transition.stub(:from) { :init }
      transition.stub(:name) { :init_to_end }

      expect(transition.from).to eq (:init)
      expect(@state.add_transition(transition)).not_to eq nil
    end

    it "rejects a transition not from state" do
      transition = double("transition")
      transition.stub(:from) { :other }
      transition.stub(:name) { :other_to_end }

      expect(transition.from).to eq (:other)
      expect(@state.add_transition(transition)).to eq nil 
    end
  end

  describe "#next_state" do
    it "return an empty array when no transitions exist" do
      expect(@state.next_state).to eq []

      transition = double("transition_with_guard")
      transition.stub(:can_transition?) { false }
      transition.stub(:name) { :unreachable }
      transition.stub(:from) { :init }
      transition.stub(:to) { :end }
      @state.add_transition(transition)
      expect(@state.next_state).to eq []
    end

    it "returns an array of the next available state names" do
      transition = double("transition")
      transition.stub(:from) { :init }
      transition.stub(:to) { :end }
      transition.stub(:name) { :init_to_end }
      transition.stub(:can_transition?) { true }

      @state.add_transition(transition)
      expect(@state.next_state).to eq [:end]

      unavailable_transition = double("unavailable_transition")
      unavailable_transition.stub(:from) { :init }
      unavailable_transition.stub(:to) { :other }
      unavailable_transition.stub(:name) { :init_to_other }
      unavailable_transition.stub(:can_transition?) { false }

      @state.add_transition(unavailable_transition)
      expect(@state.next_state.include?(:other)).to eq false
    end
  end

  describe "#next_state_transition" do
    it "returns an array the next available state transitions" do
      transition = double("transition")
      transition.stub(:from) { :init }
      transition.stub(:to) { :end }
      transition.stub(:name) { :init_to_end }
      transition.stub(:can_transition?) { true }

      @state.add_transition(transition)
      expect(@state.next_state_transition).to be_a Array
      expect(@state.next_state_transition.count).to eq 1
      expect(@state.next_state_transition.first.name).to eq :init_to_end
    end

    it "returns an empty array when no transitions are available" do
      expect(@state.next_state_transition).to eq []        
      expect(@state.next_state_transition.first).to eq nil
    end
  end

  describe "#leave" do
    it "does nothing when there is no code block" do
      @state.leave_code = nil
      expect(@state.leave).to eq nil
    end

    it "runs the code block when code block exists" do
      @state.leave_code = Proc.new { 5 }
      expect(@state.leave).to eq 5
    end
  end

  describe "#enter" do
    it "does nothing when there is no code block" do
      @state.enter_code = nil
      expect(@state.enter).to eq nil
    end

    it "runs the code block when code block exists" do
      @state.enter_code = Proc.new { 5 }
      expect(@state.enter).to eq 5
    end
  end

end
