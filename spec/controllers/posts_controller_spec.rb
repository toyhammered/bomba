require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:my_user) { create(:user) }

  context 'ApplicationController' do
    context 'CRUD action' do
      before(:each) do
        sign_in my_user
        request.env["HTTP_REFERER"] = "where_i_came_from"
      end

      describe 'POST create' do
        it 'creates a post' do
          expect { post :create, user_id: my_user, post: { body: Faker::Hipster.paragraph } }.to change(Post, :count).by(1)
        end

        it 'tracks the activity' do
          expect(Activity).to receive(:track) # set up a listener, then run the function
          post :create, user_id: my_user, post: { body: Faker::Hipster.paragraph }
        end
      end

      describe 'PUT update' do
        it 'tracks activity' do
          # we do not care about the implemenation of it, it is truly an implemenation test
          # we care that we called the Activity.tracked method
          post = create(:post, user: my_user, body: "old text")
          expect(Activity).to receive(:track) # set up a listener, then run the function
          put :update, id: post, user_id: my_user, post: { body: "new text" }
        end
      end

    end
  end
end
