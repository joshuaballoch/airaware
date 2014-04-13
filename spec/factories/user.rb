FactoryGirl.define do
  sequence :username do |n|
    "a#{SecureRandom.hex(6)}#{n}"
  end

  sequence :email do |n|
    "a#{SecureRandom.hex(6)}#{n}@example.com"
  end

  sequence :unconfirmed_email do |n|
    "a#{SecureRandom.hex(6)}#{n}@example.com"
  end

  factory :user do
    username
    email
    first_name { Randgen.first_name }
    last_name { Randgen.last_name }
    password              { "password" }
    password_confirmation { "password" }
  end

  factory :admin_user, :class => User do
    username
    email
    first_name { Randgen.first_name }
    last_name { Randgen.last_name }
    password              { "password" }
    password_confirmation { "password" }
    admin true
  end
end
