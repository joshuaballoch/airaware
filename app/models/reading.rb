class Reading < ActiveRecord::Base
  attr_accessible :reporting_device_id, :temperature, :humidity, :hcho, :co2, :tvoc, :pm2p5, :reading_time

  validates_presence_of :reporting_device_id, :reading_time

  belongs_to :reporting_device
  has_one :location, :through => :reporting_device

end
