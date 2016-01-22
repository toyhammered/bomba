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

    describe '#cancel_friendship' do
      it 'should cancel the friendship' do
        pfr = PendingFriendship.last
        pfr.accept_friendship

        fr = Friendship.last
        fr.cancel_friendship
        
        expect(Friendship.find_by(user_id: my_user, friend_id: other_user)).to be_nil
      end
    end

  end
end
