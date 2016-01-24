FactoryGirl.define do
  factory :post do
    user
    body Faker::Hipster.paragraph
  end

end
