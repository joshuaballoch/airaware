FactoryGirl.define do
  factory :reading do
    reporting_device { create :reporting_device }
    temperature { rand }
    humidity { rand }
    hcho { rand }
    co2 { rand }
    tvoc { rand }
    pm2p5 { rand }
    reading_time { Time.now }
  end
end
