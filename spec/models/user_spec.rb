require 'spec_helper'

describe User do
  context "attributes" do
    it { should respond_to :username }
    it { should respond_to :email }
    it { should respond_to :last_name }
    it { should respond_to :first_name }
    it { should respond_to :password }
    it { should respond_to :password_confirmation }
    it { should respond_to :timezone }
    it { should respond_to :remember_me }
    it { should respond_to :locale }
    it { should respond_to :admin }
  end

  context "mass assignment" do
    it { should allow_mass_assignment_of :username }
    it { should allow_mass_assignment_of :email }
    it { should allow_mass_assignment_of :last_name }
    it { should allow_mass_assignment_of :first_name }
    it { should allow_mass_assignment_of :password }
    it { should allow_mass_assignment_of :password_confirmation }
    it { should allow_mass_assignment_of :timezone }
    it { should allow_mass_assignment_of :remember_me }
    it { should allow_mass_assignment_of :locale }
    it { should_not allow_mass_assignment_of :encrypted_password }
  end

  context "validations" do
    it { should validate_presence_of :username }
    it { should validate_presence_of :email }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :first_name }
    it { should validate_uniqueness_of :username }
    it { should validate_uniqueness_of :email }
    it { should validate_uniqueness_of :last_name }
    it { should validate_uniqueness_of :first_name }
  end

  context "associations" do

  end

end
