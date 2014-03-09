class ReportingDevice < ActiveRecord::Base
  attr_accessible :location_id, :location

  validates_presence_of :location_id, :identifier

  validates_uniqueness_of :identifier

  belongs_to :location
  has_many :readings, :dependent => :destroy

end
