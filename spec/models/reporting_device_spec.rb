require 'spec_helper'

describe ReportingDevice do
  describe "attributes" do
    it { should respond_to :location_id }
    it { should respond_to :identifier }
  end

  describe "attr accessible" do
    it { should allow_mass_assignment_of     :location_id }
    it { should_not allow_mass_assignment_of :identifier }
  end

  describe "validations" do
    it { should validate_presence_of :location_id }
    it { should validate_presence_of :identifier }
  end

  describe "associations" do
    it { should have_many :readings }
    it { should belong_to :location }
  end

end
