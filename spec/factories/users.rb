FactoryGirl.define do
  pw = "password"

  factory :user do
    email { Faker::Internet.safe_email }
    username { Faker::Internet.user_name }
    password pw
    password_confirmation pw
    confirmed_at Time.now
  end

end
