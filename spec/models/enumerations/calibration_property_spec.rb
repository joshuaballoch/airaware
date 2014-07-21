require 'spec_helper'

describe CalibrationProperty do |variable|
  its(:to_a) {
    CalibrationProperty.to_a.should =~
      [
        ["Formaldehyde", 0],
        ["CO2", 1],
        ["TVOC", 2],
        ["PM 2.5", 3]
      ]
  }
end
