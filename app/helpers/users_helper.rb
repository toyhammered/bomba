module UsersHelper

  def profile_friendship_button(user)
    # no button required for yourself
    return if current_user == user
    status = current_user.friendship_status(user)

    case status[0]
      # add content tags and links for this part
    when "friends"
      link_to "Remove Friend", friendship_path(status[1]), class: "btn btn-primary", method: :delete
    when "pending"
      link_to "Cancel Request", pending_friendship_path(status[1]), class: "btn btn-primary", method: :delete
    when "requested"
      content_tag(:div) do
        (link_to "Accept", accept_pending_friendship_path(status[1]), class: "", method: :post) +
        (link_to "Delete", pending_friendship_path(status[1]), class: "", method: :delete).html_safe
      end
    when "not_friends"
      link_to "Add Friend", pending_friendships_path(user_id: user), class: "btn btn-primary", method: :post
    end
  end

end
