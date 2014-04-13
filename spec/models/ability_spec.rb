require 'spec_helper'

describe "Permissions" do
  let (:admin_user) { create :admin_user }
  let (:normal_user) { create :user }

  context "SuperUser permissions" do
    it { should allow(admin_user, :manage, :all) }
    it { should_not allow(normal_user, :manage, :all) }
  end

end
