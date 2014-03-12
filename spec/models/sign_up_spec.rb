require 'spec_helper'

describe SignUp do
  describe "attributes" do
    it { should respond_to :email }
  end

  describe "attr accessible" do
    it { should allow_mass_assignment_of     :email }
  end

  describe "validations" do
    it { should validate_presence_of :email }
  end

end
