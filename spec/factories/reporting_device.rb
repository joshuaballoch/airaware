FactoryGirl.define do
  factory :reporting_device do
    identifier { Randgen.object_id.to_s }
    location { create :location }

  end
end
