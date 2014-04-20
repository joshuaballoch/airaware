require 'spec_helper'

describe PrivacyEnumeration do |variable|
  its(:to_a) {
    PrivacyEnumeration.to_a.should =~ [
      ["Public", 0],
      ["Private", 1]
    ]
  }
end
