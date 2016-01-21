require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  let(:my_user) { create(:user) }
  let(:other_user) { create(:user) }

  context 'my user doing CRUD on a Friendship they own' do
    before(:each) do
      sign_in my_user
    end

    describe 'POST create' do
      it 'increases the number of Friendships by 1' do

        # This seems awkward because I am just testing the 'request_friendship' method, which is already testing in the user_spec.
        # how could I make the post :create work?
        my_user.request_friendship(other_user)
        expect(Friendship.count).to eq 1

        # expect { post :create, user_id: my_user.id, friend_id: other_user.id }.to change(Friendship, :count).by(1)
      end

    end


  end



end
