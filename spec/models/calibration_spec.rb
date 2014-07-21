require 'spec_helper'

describe Calibration do
  context "Enumerations" do
    subject { Calibration }

    # its (:enumerations) { should == {:calibration_type => CalibrationType, :calibration_property => CalibrationProperty }}
  end
  describe "attributes" do
    it { should respond_to :reporting_device_id }
    it { should respond_to :calibration_type }
    it { should respond_to :calibration_property }
  end

  describe "attr accessible" do
    it { should allow_mass_assignment_of     :reporting_device_id }
    it { should allow_mass_assignment_of     :calibration_type }
    it { should allow_mass_assignment_of     :calibration_property }
    ["a","b","c","d","e","f","g"].each do |l|
    	it { should allow_mass_assignment_of( :"#{l}")}
    end
  end

  describe "validations" do
    it { should validate_presence_of :reporting_device_id }
    it { should validate_presence_of :calibration_type }
    it { should validate_presence_of :calibration_property }
    it { should validate_uniqueness_of(:reporting_device_id).scoped_to(:calibration_property) }
    context "linear calibration type" do
      it "should clear c & higher factors before validate" do
        calib = Calibration.new :calibration_type => CalibrationType::LINEAR
        calib.assign_attributes(:c => 12, :d => 12, :e => 1, :f => 2, :g => 3)
        calib.valid?
        ["c","d","e","f","g"].each do |l|
          calib.send(:"#{l}").should be_nil
        end
      end
    end
  end

  describe "associations" do
    it { should belong_to :reporting_device }
  end
end
