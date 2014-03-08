require 'spec_helper'

describe Reading do
  describe "attributes" do
    it { should respond_to :reporting_device_id }
    it { should respond_to :temperature }
    it { should respond_to :humidity }
    it { should respond_to :hcho }
    it { should respond_to :co2 }
    it { should respond_to :tvoc }
    it { should respond_to :pm2p5 }
    it { should respond_to :reading_time }

  end

  describe "attr accessible" do
    it { should allow_mass_assignment_of     :reporting_device_id }
    it { should allow_mass_assignment_of     :temperature }
    it { should allow_mass_assignment_of     :humidity }
    it { should allow_mass_assignment_of     :hcho }
    it { should allow_mass_assignment_of     :co2 }
    it { should allow_mass_assignment_of     :tvoc }
    it { should allow_mass_assignment_of     :pm2p5 }
    it { should allow_mass_assignment_of     :reading_time }
  end

  describe "validations" do
    it { should validate_presence_of :reporting_device_id }
    it { should validate_presence_of :reading_time }
  end

end
