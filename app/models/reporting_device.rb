class ReportingDevice < ActiveRecord::Base
  attr_accessible :location_id

  validates_presence_of :location_id, :identifier

  belongs_to :location
  has_many :readings, :dependent => :destroy

end
