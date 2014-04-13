require 'spec_helper'

describe LocationUserRole do |variable|
  its(:to_a) {
    LocationUserRole.to_a.should =~
      [
        ["Admin", 1],
        ["Member", 0]
      ]
  }
end
