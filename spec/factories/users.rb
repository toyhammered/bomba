FactoryGirl.define do
  pw = "password"

  factory :user do
    email { Faker::Internet.safe_email }
    sequence(:username) { |x| "toyhammered#{x}" }
    password pw
    password_confirmation pw
    confirmed_at Time.now
  end

end
