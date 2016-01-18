module UsersHelper

  def profile_friendship_button(user)
    case current_user.friendship_status(user)
    when "friends"
      "Remove Friend"
    when "pending"
      "Cancel Request"
    when "requested"
      "Accept or Deny"
    when "not_friends"
      "Add as Friend"
    end
  end

end
