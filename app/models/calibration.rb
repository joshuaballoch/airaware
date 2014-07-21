class Calibration < ActiveRecord::Base
  extend EnumerateIt
  attr_accessible :reporting_device_id, :calibration_type, :calibration_property, :a, :b, :c, :d, :e, :f, :g

  validates_presence_of :reporting_device_id, :calibration_property, :calibration_type

  validates_uniqueness_of :reporting_device_id, :scope => :calibration_property

  before_validation :nullify_irrelevant_factors

  has_enumeration_for :calibration_property, :with => CalibrationProperty, :with_scopes => true, :with_helpers => true
  has_enumeration_for :calibration_type, :with => CalibrationType, :with_scopes => true, :with_helpers => true

  belongs_to :reporting_device

  private

  	def nullify_irrelevant_factors
  		if self.calibration_type == CalibrationType::LINEAR
        self.assign_attributes(:c => nil, :d => nil, :e => nil, :f => nil, :g => nil)
      end
  	end
end
