class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates_presence_of :user_id
  validates_presence_of :friend_id

  enum status: [:pending, :active]

  validates_uniqueness_of :user_id, scope: :friend_id
  validates_uniqueness_of :friend_id, scope: :user_id

  def accept_friendship
    self.update_attributes(status: :active, friended_at: Time.now)
  end

  def deny_friendship
    self.destroy
  end

  def cancel_friendship
    self.destroy
  end

end
