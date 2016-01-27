require 'rails_helper'

RSpec.describe PendingFriendship, type: :model do
  let!(:my_user) { create(:user) }
  let!(:other_user) { create(:user)}

  # it { should validate_presence_of(:user_id) }
  # it { should validate_presence_of(:friend_id) }

  it { should belong_to(:user) }
  it { should belong_to(:friend) }


  context 'instances' do
    # before(:each) do
    #   my_user.request_friendship(other_user)
    # end

    describe '#accept_friendship' do

      it 'should create new friendship' do
          this_user = create(:user)
          friend = create(:user)

          # puts "*" * 10
          # puts this_user.username
          # puts friend.username
          # puts "*" * 10
          pfr = this_user.request_friendship(friend)
          p PendingFriendship.all
          p Friendship.all

          expect(PendingFriendship.where(id: pfr.id).take).to_not be_nil

          fr = pfr.accept_friendship
          expect(fr).to_not be_nil
      end

      it 'should destroy pending friendship' do
        this_user = create(:user)
        friend = create(:user)
        puts "*" * 10
        puts this_user.username
        puts friend.username
        puts "*" * 10
        pfr = this_user.request_friendship(friend)
        expect(PendingFriendship.where(id: pfr.id).take).to_not be_nil
        pfr.accept_friendship
        expect(PendingFriendship.where(id: pfr.id).take).to be_nil
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
