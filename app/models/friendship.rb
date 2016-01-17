class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"

  enum status: [:pending, :active]


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
