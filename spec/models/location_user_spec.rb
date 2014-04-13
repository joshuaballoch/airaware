require 'spec_helper'

describe LocationUser do
  context "Enumerations" do
    subject { LocationUser }

    its (:enumerations) { should == {:role => LocationUserRole } }
  end

  context "attributes" do
    it { should respond_to :user_id }
    it { should respond_to :location_id }
    it { should respond_to :role }
  end

  context "validations" do
    it { should validate_presence_of :user }
    it { should validate_presence_of :location }
    it { should validate_presence_of :role }
    it { should validate_uniqueness_of(:user_id).on(:location_id) }

    it "should not be able to destroy if user is location.user" do
      location = create :location
      location_user = location.location_users.first
      expect {
        location_user.destroy
      }.not_to change(LocationUser,:count)
    end
  end

  context "mass assmts" do
    it { should allow_mass_assignment_of :user }
    it { should allow_mass_assignment_of :user_id }
    it { should allow_mass_assignment_of :location }
    it { should allow_mass_assignment_of :location_id }
    it { should allow_mass_assignment_of :role }
  end

  context "associations" do
    it { should belong_to :user }
    it { should belong_to :location }
  end
end
