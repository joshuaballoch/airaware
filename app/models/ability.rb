class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    else
      normal_user_permissions(user)
    end

  end

  def normal_user_permissions(user)
    normal_user_location_permissions(user)
    normal_user_reporting_device_permissions(user)
    normal_user_readings_permissions(user)
  end

  def normal_user_location_permissions(user)
    can [:new, :create], Location if !user.new_record?
    can [:update, :destroy], Location do |location|
      location.admins.include? user
    end
    can [:read], Location do |location|
      if location.public?
        true
      else
        location.users.include? user
      end
    end
  end

  def normal_user_reporting_device_permissions(user)
    can [:new], ReportingDevice if !user.new_record?
    can :create, ReportingDevice do |reporting_device|
      if reporting_device.location
        can? :update, reporting_device.location
      else
        false
      end
    end

    can [:update, :destroy], ReportingDevice do |reporting_device|
      can? :update, reporting_device.location
    end
    can [:read], ReportingDevice do |reporting_device|
      can? :read, reporting_device.location
    end
  end

  def normal_user_readings_permissions(user)
    cannot [:new, :create, :update, :destroy], Reading
    can [:read], Reading do |reading|
      can? :read, reading.reporting_device
    end
  end
end
