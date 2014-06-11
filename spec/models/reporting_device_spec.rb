require 'spec_helper'

describe ReportingDevice do
  context "Enumerations" do
    subject { ReportingDevice }

    its (:enumerations) { should == {:device_type => ReportingDeviceType }}
  end
  describe "attributes" do
    it { should respond_to :location_id }
    it { should respond_to :identifier }
    it { should respond_to :device_type }
  end

  describe "attr accessible" do
    it { should allow_mass_assignment_of     :location_id }
    it { should allow_mass_assignment_of     :location }
    it { should allow_mass_assignment_of     :device_type }
    it { should_not allow_mass_assignment_of :identifier }
  end

  describe "validations" do
    it { should validate_presence_of :location_id }
    it { should validate_presence_of :identifier }
    it { should validate_presence_of :device_type }
    it { create :reporting_device ; should validate_uniqueness_of(:identifier).scoped_to(:device_type) }
  end

  describe "associations" do
    it { should have_many :readings }
    it { should belong_to :location }
  end

end
