class Location < ActiveRecord::Base
  attr_accessible :name, :description

  validates_presence_of :name

  has_many :reporting_devices, :dependent => :destroy
  has_many :readings, :through => :reporting_devices
end
