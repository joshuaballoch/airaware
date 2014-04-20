require 'spec_helper'

describe Location do
  context "Enumerations" do
    subject { Location }
    its(:enumerations) { should == {:privacy => PrivacyEnumeration } }
  end
  describe "attributes" do
    it { should respond_to :name }
    it { should respond_to :description }
    it { should respond_to :privacy }
  end

  describe "attr accessible" do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :user }
    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :privacy }
    it { should_not allow_mass_assignment_of :user_id }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :user }
    it { should validate_presence_of :privacy }
  end

  describe "associations" do
    it { should have_many :reporting_devices }
    it { should have_many(:readings).through(:reporting_devices) }
    it { should belong_to(:user) }
    it { should have_many :location_users }
    it { should have_many(:users).through(:location_users) }
    it { should have_many(:admins).through(:location_users) }
    context "#admins" do
      before :all do
        @location = create :location
        @admin = @location.user
        @member = create :user
        @location.location_users.create :user => @member, :role => LocationUserRole::MEMBER
      end

      it "should include admins" do
        @location.admins.should include @admin
      end

      it "should not include members" do
        @location.admins.should_not include @member
      end
    end
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
