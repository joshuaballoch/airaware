class ReportingDevice < ActiveRecord::Base
  extend EnumerateIt

  attr_accessible :location_id, :location, :device_type
  attr_accessible :identifier, :device_type, :location_id, :as => :admin

  validates_presence_of :location_id, :identifier, :device_type

  validates_uniqueness_of :identifier, :scope => :device_type

  has_enumeration_for :device_type, :with => ReportingDeviceType, :create_scopes => true, :create_helpers => true

  belongs_to :location
  has_many :readings, :dependent => :destroy

end
