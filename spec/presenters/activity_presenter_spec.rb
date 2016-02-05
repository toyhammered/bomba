require 'rails_helper'

RSpec.describe ActivityPresenter, type: :presenter do
  include ActionView::TestCase::Behavior

  it 'not sure what to test' do
    my_user = create(:user)
    post = create(:post, user: my_user)
    Activity.track(my_user, post, "create")
    activity = Activity.last

    presenter = ActivityPresenter.new(activity, view).render_activity

  end
end
