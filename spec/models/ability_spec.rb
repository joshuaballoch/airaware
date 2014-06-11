require 'spec_helper'

describe "Permissions" do
  let (:admin_user) { create :admin_user }
  let (:normal_user) { create :user }
  let (:guest) { User.new }

  context "SuperUser permissions" do
    it { should allow(admin_user, :manage, :all) }
    it { should_not allow(normal_user, :manage, :all) }
  end

  context "Normal Users" do

    context "on locations" do
      it { should allow(normal_user, :new, Location) }
      it { should_not allow(guest, :new, Location) }
      it { should allow(normal_user, :create, Location.new) }
      it { should_not allow(guest, :create, Location.new) }

      context "that exist" do
        before :all do
          @private_location = create :location, :private
          @public_location = create :location, :public
          @location_admin = create :user
          @location_member = create :user
          [@private_location, @public_location].each do |loc|
            loc.location_users.create :user => @location_admin, :role => LocationUserRole::ADMIN
            loc.location_users.create :user => @location_member, :role => LocationUserRole::MEMBER
          end
        end
        describe "update permissions" do
          it { should allow @location_admin, :update, @private_location }
          it { should_not allow @location_member, :update, @private_location }
          it { should_not allow normal_user, :update, @private_location }

          it { should allow @location_admin, :update, @public_location }
          it { should_not allow @location_member, :update, @public_location }
          it { should_not allow normal_user, :update, @public_location }
        end

        describe "read permissions" do
          context "when private" do
            it { should allow @location_admin, :read, @private_location }
            it { should allow @location_member, :read, @private_location }
            it { should_not allow normal_user, :read, @private_location }
          end
          context "when public" do
            it { should allow @location_admin, :read, @public_location }
            it { should allow @location_member, :read, @public_location }
            it { should allow normal_user, :read, @public_location }
            it { should allow guest, :read, @public_location }
          end
        end

        describe "destroy permissions" do
          it { should allow @location_admin, :destroy, @private_location }
          it { should_not allow @location_member, :destroy, @private_location }
          it { should_not allow normal_user, :destroy, @private_location }

          it { should allow @location_admin, :destroy, @public_location }
          it { should_not allow @location_member, :destroy, @public_location }
          it { should_not allow normal_user, :destroy, @public_location }
        end
      end
    end
    context "Reporting Devices" do
      before :all do
        # Create locations
        @private_location = create :location, :private
        @public_location = create :location, :public
        @location_admin = create :user
        @location_member = create :user
        [@private_location, @public_location].each do |loc|
          loc.location_users.create :user => @location_admin, :role => LocationUserRole::ADMIN
          loc.location_users.create :user => @location_member, :role => LocationUserRole::MEMBER
        end
      end

      # It should allow anybody to access the "new" page
      it { should allow(normal_user, :new, ReportingDevice) }
      it { should_not allow(guest, :new, ReportingDevice) }

      it "should allow create if an admin of the location" do
        device = ReportingDevice.new :location => @private_location

        should allow(@location_admin, :create, device)
        should_not allow(@location_member, :create, device)
        should_not allow(normal_user, :create, device)
        should_not allow(guest, :create, device)
      end

      context "existing reporting_devices" do
        before :all do
          @private_loc_device = create :reporting_device, :location => @private_location
          @public_loc_device = create :reporting_device, :location => @public_location
        end
        describe "update" do
          it { should allow @location_admin, :update, @private_loc_device }
          it { should_not allow @location_member, :update, @private_loc_device }
          it { should_not allow normal_user, :update, @private_loc_device }

          it { should allow @location_admin, :update, @public_loc_device }
          it { should_not allow @location_member, :update, @public_loc_device }
          it { should_not allow normal_user, :update, @public_loc_device }
        end

        describe "read" do
          it { should allow @location_admin, :read, @private_loc_device }
          it { should allow @location_member, :read, @private_loc_device }
          it { should_not allow normal_user, :read, @private_loc_device }

          it { should allow @location_admin, :read, @public_loc_device }
          it { should allow @location_member, :read, @public_loc_device }
          it { should allow normal_user, :read, @public_loc_device }
        end

        describe "destroy" do
          it { should allow @location_admin, :destroy, @private_loc_device }
          it { should_not allow @location_member, :destroy, @private_loc_device }
          it { should_not allow normal_user, :destroy, @private_loc_device }

          it { should allow @location_admin, :destroy, @public_loc_device }
          it { should_not allow @location_member, :destroy, @public_loc_device }
          it { should_not allow normal_user, :destroy, @public_loc_device }
        end
      end
    end

    context "Readings" do
      before :all do
        # Create locations
        @private_location = create :location, :private
        @public_location = create :location, :public
        @location_admin = create :user
        @location_member = create :user
        [@private_location, @public_location].each do |loc|
          loc.location_users.create :user => @location_admin, :role => LocationUserRole::ADMIN
          loc.location_users.create :user => @location_member, :role => LocationUserRole::MEMBER
        end
        @private_loc_device = create :reporting_device, :location => @private_location
        @public_loc_device = create :reporting_device, :location => @public_location
      end

      # It should allow anybody to access the "new" page
      it { should_not allow(normal_user, :new, Reading) }

      # It should not allow creation of any reporting device
      it { should_not allow normal_user, :create, Reading }

      context "existing readings" do
        before :all do
          @private_reading = create :reading, :reporting_device => @private_loc_device
          @public_reading = create :reading, :reporting_device => @public_loc_device
        end
        describe "update" do
          it { should_not allow @location_admin, :update, @private_reading }
          it { should_not allow @location_member, :update, @private_reading }
          it { should_not allow normal_user, :update, @private_reading }

          it { should_not allow @location_admin, :update, @public_reading }
          it { should_not allow @location_member, :update, @public_reading }
          it { should_not allow normal_user, :update, @public_reading }
        end

        describe "read" do
          it { should allow @location_admin, :read, @private_reading }
          it { should allow @location_member, :read, @private_reading }
          it { should_not allow normal_user, :read, @private_reading }

          it { should allow @location_admin, :read, @public_reading }
          it { should allow @location_member, :read, @public_reading }
          it { should allow normal_user, :read, @public_reading }
        end

        describe "destroy" do
          it { should_not allow @location_admin, :destroy, @private_reading }
          it { should_not allow @location_member, :destroy, @private_reading }
          it { should_not allow normal_user, :destroy, @private_reading }

          it { should_not allow @location_admin, :destroy, @public_reading }
          it { should_not allow @location_member, :destroy, @public_reading }
          it { should_not allow normal_user, :destroy, @public_reading }
        end
      end
    end


  end

end
