class LocationAdminWatcher < ActiveRecord::Base
  # Extend EnumerateIt for enumeration support
  extend EnumerateIt

  ## Mass Assignment
  attr_accessible :user, :user_id, :location, :location_id, :as => :admin

  ## Validations
  #
  validates_presence_of :user, :location

  validates_uniqueness_of :user_id, :scope => [:location_id]
  validate :user_is_an_admin, :if => :user

  ## Associations
  #
  belongs_to :user
  belongs_to :location

  private

    def user_is_an_admin
      unless user.admin?
        errors.add :user, "must be an AirAware admin"
      end
    end

end
