module UsersHelper

  def profile_friendship_button(user)
    case current_user.friendship_status(user)
      # add content tags and links for this part
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
