class LocationUser < ActiveRecord::Base
  # Extend EnumerateIt for enumeration support
  extend EnumerateIt

  ## Mass Assignment
  attr_accessible :user, :user_id, :location, :location_id, :role
  attr_accessible :user, :user_id, :location, :location_id, :role, :as => :admin

  ## Validations
  #
  validates_presence_of :user, :location, :role

  validates_uniqueness_of :user_id, :scope => [:location_id]

  ## Associations
  #
  belongs_to :user
  belongs_to :location

  ## Enumerations
  #
  has_enumeration_for :role, :with => LocationUserRole, :create_scopes => true, :create_helpers => true

  ## Special Transaction Logic

  before_destroy :check_if_location_admin

  private

    def check_if_location_admin
      return false if self.location.user == self.user
    end
end
