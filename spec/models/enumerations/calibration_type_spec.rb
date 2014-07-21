require 'spec_helper'

describe CalibrationType do |variable|
  its(:to_a) {
    CalibrationType.to_a.should =~
      [
        ["Linear (y=ax+b)", 0]
      ]
  }
end
