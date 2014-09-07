require 'airaware/status'

class Location < ActiveRecord::Base
  # Extend EnumerateIt for enumeration support
  extend EnumerateIt

  attr_accessible :name, :description, :user, :privacy
  attr_accessible :name, :description, :user, :active, :user_id, :privacy, :location_users_attributes, :city, :temperature, :humidity, :hcho, :co2,  :tvoc, :pm2p5, :as => :admin


  ## VALIDATIONS
  #

  validates_presence_of :name, :user, :privacy

  ## ASSOCIATIONS
  #

  has_many :reporting_devices, :dependent => :destroy
  has_many :readings, :through => :reporting_devices

  has_many :location_users, :dependent => :destroy
  accepts_nested_attributes_for :location_users

  has_many :users, :through => :location_users
  has_many :admins, :through => :location_users, :source => :user, :conditions => proc { ['`location_users`.`role` = ?', LocationUserRole::ADMIN] }

  belongs_to :user

  ## Enumerations
  #
  has_enumeration_for :privacy, :with => PrivacyEnumeration, :create_scopes => true, :create_helpers => true
  has_enumeration_for :city, :with => City, :create_scopes => true, :create_helpers => true

  ## SPECIAL TRANSACTION LOGIC
  #

  before_save :build_location_user

  scope :active, where('`locations`.`active` = ?', true)

  def stale?
    readings.ordered.first.reading_time <= AirAware::Status.stale_time_comparison
  end

  private

    def build_location_user
      unless self.users.include? self.user
        self.location_users.build :user => self.user, :role => LocationUserRole::ADMIN
      end
    end
end
