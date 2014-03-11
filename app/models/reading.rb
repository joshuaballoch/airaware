class Reading < ActiveRecord::Base
  # TO DO : sanitize input!!
  attr_accessible :reporting_device_id, :temperature, :humidity, :hcho, :co2, :tvoc, :pm2p5, :reading_time

  validates_presence_of :reporting_device_id, :reading_time

  validates_uniqueness_of :reading_time, :scope => :reporting_device_id

  belongs_to :reporting_device
  has_one :location, :through => :reporting_device

  # TO DO: ADD TEST FOR THIS
  scope :ordered, order('reading_time DESC')

end
