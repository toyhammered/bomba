require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:my_user) { create(:user) }

  context 'ApplicationController' do
    context 'CRUD action' do
      before(:each) do
        sign_in my_user
        request.env["HTTP_REFERER"] = "where_i_came_from"
      end

      context 'POST create' do
        describe '#track_activity' do
          it 'creates an Activity when a post is created' do
            post :create, user_id: my_user, post: { body: Faker::Hipster.paragraph }
            expect(Post.count).to eq 1
            expect(Activity.count).to eq 1
          end
        end
      end

      context 'PUT update' do
        describe '#track_activity' do
          it 'should not contain multiple UPDATE records on same trackable object by the same user' do
            post :create, user_id: my_user, post: { body: Faker::Hipster.paragraph }
            post = Post.last

            3.times do
              put :update, id: post, post: { body: Faker::Hipster.paragraph }
            end

            expect(Activity.where(action: "update").count).to eq 1
          end
        end
      end

    end
  end
end
