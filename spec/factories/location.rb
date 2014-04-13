FactoryGirl.define do
  factory :location do
    name { Randgen.word }
    description { Randgen.sentence }
    user
  end
end
