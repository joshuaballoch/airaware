require 'spec_helper'

describe Location do
  describe "attributes" do
    it { should respond_to :name }
    it { should respond_to :description }
  end

  describe "attr accessible" do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :user }
    it { should allow_mass_assignment_of :description }
    it { should_not allow_mass_assignment_of :user_id }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :user }
  end

  describe "associations" do
    it { should have_many :reporting_devices }
    it { should have_many(:readings).through(:reporting_devices) }
    it { should belong_to(:user) }
    it { should have_many :location_users }
    it { should have_many(:users).through(:location_users) }
  end

  context "location users" do
    it "should create admin location_user for its user on create" do
      user = create :user
      location = Location.new attributes_for(:location).merge(:user => user)
      expect {
        location.save.should be_true
      }.to change(LocationUser, :count).by(1)
      location.users.should include user
      LocationUser.last.role.should == LocationUserRole::ADMIN
    end
  end
end
