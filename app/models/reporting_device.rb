class ReportingDevice < ActiveRecord::Base
  extend EnumerateIt

  attr_accessible :location_id, :location, :device_type
  attr_accessible :identifier, :device_type, :location_id, :label, :calibrations_attributes, :as => :admin

  validates_presence_of :location_id, :identifier, :device_type

  validates_uniqueness_of :identifier, :scope => :device_type

  has_enumeration_for :device_type, :with => ReportingDeviceType, :create_scopes => true, :create_helpers => true

  belongs_to :location
  has_many :readings, :dependent => :destroy

  has_many :calibrations, :dependent => :destroy
  accepts_nested_attributes_for :calibrations, :allow_destroy => true
  has_one :tvoc_calibration, :class_name => "Calibration", :conditions => ['calibration_property = ?', CalibrationProperty::TVOC]
  has_one :hcho_calibration, :class_name => "Calibration", :conditions => ['calibration_property = ?', CalibrationProperty::HCHO]
  has_one :pm2p5_calibration, :class_name => "Calibration", :conditions => ['calibration_property = ?', CalibrationProperty::PM2P5]
  has_one :co2_calibration, :class_name => "Calibration", :conditions => ['calibration_property = ?', CalibrationProperty::CO2]

  # These seem low performing
  # scope :with_readings, includes(:readings).where("(select count(*) from readings) > 0")
  # scope :stale, includes(:readings).where("(select count(*) from readings where reading_time >= ?) = 0", 1.hour.ago)

end
