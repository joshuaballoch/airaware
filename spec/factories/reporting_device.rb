FactoryGirl.define do
  sequence :identifier do |n|
    "123.as.#{n}"
  end
  factory :reporting_device do
    identifier
    location { create :location }
    device_type { rand(0..1) }
  end
end
