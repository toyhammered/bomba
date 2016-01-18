FactoryGirl.define do
  factory :friendship do
    user
    friend
    status 0
    friended_at Time.now
  end
end
