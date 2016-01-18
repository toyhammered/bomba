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
      it 'should create friendship with valid users' do
        expect { my_user.request_friendship(other_user) }.to change(Friendship, :count).by(1)
      end

      it 'should not create friendship if it already exists' do
        my_user.request_friendship(other_user)
        expect{ my_user.request_friendship(other_user) }.to change(Friendship, :count).by(0)
      end

      it 'should not create friendship as visa versa if it already exists' do
        other_user.request_friendship(my_user)
        expect{ other_user.request_friendship(my_user) }.to change(Friendship, :count).by(0)
      end

      it 'should not create friendship between the same 2 users' do
        expect{ my_user.request_friendship(my_user) }.to change(Friendship, :count).by(0)
      end

      it 'should create default status of pending' do
        my_user.request_friendship(other_user)
        expect(Friendship.last.pending?).to eq true
        expect(Friendship.last.active?).to eq false
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
        f = Friendship.last
        f.accept_friendship
        expect(my_user.active_friends.count).to eql 1
        expect(other_user.active_friends.count).to eql 1
      end
    end

  end
end
