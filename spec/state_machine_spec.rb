require 'spec_helper'

describe StateMachine do

  describe "#new" do
    before :each do
      @init_state = double("state")
      @init_state.stub(:name) { :init }
      @init_state.stub(:enter) { true }
    end

    it "takes an name and initial state and returns an StateMachine" do
      @state_machine = StateMachine.new(:fsm, @init_state)
      expect(@state_machine).to be_an_instance_of StateMachine
    end

    it "enters the initial state provided" do
      @state_machine = StateMachine.new(:fsm, @init_state)
      expect(@init_state).to have_received(:enter)
    end
  end

  describe "#add_state" do
    before :each do
      @init_state = double("state")
      @init_state.stub(:name) { :init }
      @init_state.stub(:enter) { true }
      @state_machine = StateMachine.new(:fsm, @init_state)
      @add_state = double("state")
      @add_state.stub(:name) { :next }
    end

    it "adds a state when a state is provided" do
      expect(@state_machine.add_state(@add_state)).to be_truthy
    end

    it "doesn't add a state when a state is not provided" do
      expect(@state_machine.add_state(nil)).to be_falsey 
    end
  end

  describe "#add_transition" do
    before :each do
      @transition = double("transition")
      @transition.stub(:from) { :init }
      @transition.stub(:to) { :next }
      @transition.stub(:name) { :init_to_next }
      @transition.stub(:can_transition?) { true }
      @transition.stub(:execute) { true }

      @init_state = double("state")
      @init_state.stub(:name) { :init }
      @init_state.stub(:enter) { true }
      @init_state.stub(:add_transition) { true }

      @to_state = double("state")
      @to_state.stub(:name) { :next }
      @to_state.stub(:enter) { true}
      @to_state.stub(:add_transition) { true }

      @state_machine = StateMachine.new(:fsm, @init_state)
      @state_machine.add_state(@to_state)
    end     

    it "adds a transition when a transition is provided" do
      expect(@state_machine.add_transition(@transition)).to be_truthy 
    end

    it "doesn't add a transition when a transition is not provided" do
      expect(@state_machine.add_transition(nil)).to be_falsey
    end

    it "doesn't add a transition when the from state doesn't exist in the machine" do
      @transition.stub(:from) { :nonexistent }
      expect(@state_machine.add_transition(@transition)).to be_falsey
    end

    it "doesn't add a transition when the to state doesn't exist in the machine" do
      @transition.stub(:to) { :nonexistent }
      expect(@state_machine.add_transition(@transition)).to be_falsey
    end
  end

  describe "#transition" do
    before :each do
      @init_state = double("state")
      @init_state.stub(:name) { :init }
      @init_state.stub(:enter) { true }
      
      @next_state = double("state")
      @next_state.stub(:name) { :next }
      @next_state.stub(:enter) { true }

      @state_machine = StateMachine.new(:fsm, @init_state)
    end
  end
end
