class Location < ActiveRecord::Base
  attr_accessible :name, :description, :user

  ## VALIDATIONS
  #

  validates_presence_of :name, :user

  ## ASSOCIATIONS
  #

  has_many :reporting_devices, :dependent => :destroy
  has_many :readings, :through => :reporting_devices

  has_many :location_users, :dependent => :destroy
  has_many :users, :through => :location_users

  belongs_to :user

  ## SPECIAL TRANSACTION LOGIC
  #

  before_save :build_location_user

  private

    def build_location_user
      unless self.users.include? self.user
        self.location_users.build :user => self.user, :role => LocationUserRole::ADMIN
      end
    end
end
