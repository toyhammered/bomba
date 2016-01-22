require 'rails_helper'

RSpec.describe User, type: :model do

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }

  it { should have_many(:friendships) }
  it { should have_many(:inverse_friendships) }

  let(:my_user) { create(:user) }
  let(:other_user) { create(:user) }

  context 'instances' do
    describe '#request_friendship' do
      it 'should create pending friendship with valid users' do
        expect { my_user.request_friendship(other_user) }.to change(PendingFriendship, :count).by(1)
      end

      it 'should not create pending friendship if it already exists' do
        my_user.request_friendship(other_user)
        expect{ my_user.request_friendship(other_user) }.to change(PendingFriendship, :count).by(0)
      end

      it 'should not create pending friendship as visa versa if it already exists' do
        other_user.request_friendship(my_user)
        expect{ other_user.request_friendship(my_user) }.to change(PendingFriendship, :count).by(0)
      end

      it 'should not create pending friendship between the same 2 users' do
        expect{ my_user.request_friendship(my_user) }.to change(PendingFriendship, :count).by(0)
      end

      it 'should not create 2 records of the same pending friendship' do
        # user_id: 1, friend_id: 2
        # user_id: 2, friend_id: 1
        my_user.request_friendship(other_user)
        other_user.request_friendship(my_user)
        expect(PendingFriendship.count).to eql 1
      end

    end

    describe '#pending_friend_requests_from' do
      it 'should show all requests that have been sent to you' do
        other_user.request_friendship(my_user)
        expect(my_user.pending_friend_requests_from.count).to eql 1
      end
    end

    describe '#pending_friend_requests_to' do
      it 'should show all requests that I have sent to others' do
        my_user.request_friendship(other_user)
        expect(my_user.pending_friend_requests_to.count).to eql 1
      end
    end

    describe '#active_friends' do
      it 'shows all your current friends' do
        my_user.request_friendship(other_user)
        f = PendingFriendship.last
        f.accept_friendship
        expect(my_user.active_friends.count).to eql 1
        expect(other_user.active_friends.count).to eql 1
      end
    end

    describe '#friendship_status' do
      context 'returns the correct status as string' do
        it 'should return not_friends' do
          status = my_user.friendship_status(other_user)
          expect(status[0].to_s).to eq "not_friends"
        end

        it 'should return friends' do
          my_user.request_friendship(other_user)
          f = PendingFriendship.last
          f.accept_friendship
          status = my_user.friendship_status(other_user)

          expect(status[0].to_s).to eq "friends"
        end

        it 'should return pending' do
          my_user.request_friendship(other_user)
          status = my_user.friendship_status(other_user)

          expect(status[0].to_s).to eq "pending"
        end

        it 'should return requested' do
          other_user.request_friendship(my_user)
          status = my_user.friendship_status(other_user)

          expect(status[0].to_s).to eq "requested"
        end
      end
    end

  end
end
