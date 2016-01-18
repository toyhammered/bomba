require 'rails_helper'

RSpec.describe Friendship, type: :model do

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:friend_id) }

  it { should belong_to(:user) }
  it { should belong_to(:friend) }

  let(:my_user) { create(:user) }
  let(:other_user) { create(:user)}

  context 'instances' do
    before(:each) do
      my_user.request_friendship(other_user)
    end
    describe '#accept_friendship' do

      it 'should update the correct attributes' do
          f = Friendship.last
          expect(f.pending?).to eq true
          f.accept_friendship
          expect(f.active?).to eq true
      end
    end

    describe '#deny_friendship' do
      it 'should deny the friendship' do
        f = Friendship.last
        f.deny_friendship
        expect(Friendship.find_by(user_id: my_user, friend_id: other_user)).to be_nil
      end
    end

    describe '#cancel_friendship' do
      it 'should cancel the friendship' do
        f = Friendship.last
        f.accept_friendship
        f.cancel_friendship
        expect(Friendship.find_by(user_id: my_user, friend_id: other_user)).to be_nil
      end
    end

  end
end
