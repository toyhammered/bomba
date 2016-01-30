require 'rails_helper'

RSpec.describe Friendship, type: :model do

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:friend_id) }

  it { should belong_to(:user) }
  it { should belong_to(:friend) }

  let(:my_user) { create(:user) }
  let(:other_user) { create(:user)}

  context 'instances' do
    describe '#cancel_friendship' do
      it 'should cancel the friendship' do
        this_user = create(:user)
        friend = create(:user)
        pfr = this_user.request_friendship(friend)

        pfr.accept_friendship

        fr = Friendship.last
        fr.cancel_friendship

        expect(Friendship.find_by(user_id: my_user, friend_id: other_user)).to be_nil
      end
    end
  end

  context 'validations' do
    describe '#inverse_friendship_relationship_does_not_exist' do
      pending "need to add this for friendships.rb"
    end
  end
end
