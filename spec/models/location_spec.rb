require 'spec_helper'

describe Location do
  describe "attributes" do
    it { should respond_to :name }
    it { should respond_to :description }
  end

  describe "attr accessible" do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :description }
    it { should_not allow_mass_assignment_of :user_id }
  end

  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "associations" do
    it { should have_many :reporting_devices }
    it { should have_many(:readings).through(:reporting_devices) }
  end
end
