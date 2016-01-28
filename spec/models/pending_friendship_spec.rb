require 'rails_helper'

RSpec.describe PendingFriendship, type: :model do
  # it { should validate_presence_of(:user_id) }
  # it { should validate_presence_of(:friend_id) }

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

          print "Pending: "
          p PendingFriendship.all
          print "Friendship: "
          p Friendship.all

          pfr = PendingFriendship.last

          expect(PendingFriendship.where(id: pfr.id).take).to_not be_nil

          pfr.accept_friendship
          fr = Friendship.last
          puts "After"
          print "Pending: "
          p PendingFriendship.all
          print "Friendship: "
          p fr
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
    describe '#inverse_pending_friendship_relationship_does_not_exist' do
      pending "need to figure out how to make this work with new model structure"
    end
  end

end
