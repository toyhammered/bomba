FactoryGirl.define do
  factory :activity do
    user
    trackable_id
    trackable_type
    action
  end

end
