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

  end
end
