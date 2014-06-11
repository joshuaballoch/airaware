require 'spec_helper'

describe ReportingDeviceType do |variable|
  its(:to_a) {
    ReportingDeviceType.to_a.should =~
      [
        ["Fluke", 0],
        ["AirAdvice", 1]
      ]
  }
end
