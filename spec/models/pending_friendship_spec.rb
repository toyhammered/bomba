require 'rails_helper'

RSpec.describe PendingFriendship, type: :model do

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

      it 'should create new friendship' do
          pfr = PendingFriendship.last
          pfr.accept_friendship
          fr = Friendship.last
          expect(fr).to_not be_nil
      end

      it 'should destroy pending friendship' do
        pfr = PendingFriendship.last
        pfr.accept_friendship
        pfr = PendingFriendship.last
        expect(pfr).to be_nil
      end
    end

    describe '#deny_friendship' do
      it 'should deny the friendship' do
        pfr = PendingFriendship.last
        pfr.deny_friendship
        expect(PendingFriendship.find_by(user_id: my_user, friend_id: other_user)).to be_nil
      end
    end

  end # end of instances

  context 'validations' do
    describe '#inverse_pending_friendship_relationship_does_not_exist' do
      pending "need to figure out how to make this work with new model structure"
    end
  end

end
