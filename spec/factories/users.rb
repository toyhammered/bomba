FactoryGirl.define do
  pw = "password"

  factory :user do
    email { Faker::Internet.safe_email }
    # username { Faker::Internet.user_name}
    sequence(:username) { |x| "fake#{x}" }
    password pw
    password_confirmation pw
    confirmed_at Time.now
  end

end
