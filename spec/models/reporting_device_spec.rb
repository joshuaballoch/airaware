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
    context "calibrations" do
      before do
        @reporting_device = create :reporting_device
      end
      it { should have_many :calibrations }
      it "should have one tvoc calibration" do
        calibratio :class_name => "Calibration", :conditions => ['calibration_property = ?', CalibrationProperty::HCHO]
  has_one :pm2p5_calibration, :class_name => "Calibration", :conditions => ['calibration_property = ?', CalibrationProperty::PM2P5]
  has_one :co2_calibration, :class_name => "Calibration", :conditions => ['calibration_property = ?', CalibrationProperty::CO2]n = @reporting_device.calibrations.create :calibration_type => CalibrationType::LINEAR, :calibration_property => CalibrationProperty::TVOC
        @reporting_device.tvoc_calibration.should == calibration
      end
      it "should have one hcho calibration" do
        calibration = @reporting_device.calibrations.create :calibration_type => CalibrationType::LINEAR, :calibration_property => CalibrationProperty::HCHO
        @reporting_device.hcho_calibration.should == calibration
      end
      it "should have one pm2p5 calibration" do
        calibration = @reporting_device.calibrations.create :calibration_type => CalibrationType::LINEAR, :calibration_property => CalibrationProperty::PM2P5
        @reporting_device.pm2p5_calibration.should == calibration
      end
      it "should have one co2 calibration" do
        calibration = @reporting_device.calibrations.create :calibration_type => CalibrationType::LINEAR, :calibration_property => CalibrationProperty::CO2
        @reporting_device.co2_calibration.should == calibration
      end

    end
  end

end
