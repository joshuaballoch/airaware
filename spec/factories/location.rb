FactoryGirl.define do
  factory :location do
    name { Randgen.word }
    description { Randgen.sentence }
    user

    trait :public do
      privacy { PrivacyEnumeration::PUBLIC }
    end

    trait :private do
      privacy { PrivacyEnumeration::PRIVATE }
    end
  end
end
