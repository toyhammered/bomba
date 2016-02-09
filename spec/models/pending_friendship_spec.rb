require 'rails_helper'

RSpec.describe PendingFriendship, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:friend) }

  context 'instances' do
    describe '#accept_friendship' do
      before(:each) do
        my_user = create(:user)
        other_user = create(:user)
        my_user.request_friendship(other_user)
      end
      it 'should create new friendship' do
          pfr = PendingFriendship.last
          expect(PendingFriendship.where(id: pfr.id).take).to_not be_nil

          pfr.accept_friendship
          fr = Friendship.last
          expect(fr).to_not be_nil
      end

      it 'should destroy pending friendship' do
        pfr = PendingFriendship.last
        expect(PendingFriendship.where(id: pfr.id).take).to_not be_nil
        pfr.accept_friendship
        expect(PendingFriendship.where(id: pfr.id).take).to be_nil
      end

    end

    describe '#deny_friendship' do
      it 'should deny the friendship' do
        my_user = create(:user)
        other_user = create(:user)
        my_user.request_friendship(other_user)

        pfr = PendingFriendship.last
        pfr.deny_friendship
        expect(PendingFriendship.last).to be_nil
      end
    end

  end # end of instances

  context 'validations' do
    describe '#friendship_relationship_does_not_exist' do
      pending "need to add this for pending_friendship.rb"
    end
  end

end
