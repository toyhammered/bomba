module UsersHelper

  def profile_friendship_button(user)
    # no button required for yourself
    return if current_user == user
    case current_user.friendship_status(user)
      # add content tags and links for this part
    when "friends"
      link_to "Remove Friend", friendship_path(current_user.friendship_relation(user)), class: "btn btn-primary", method: :delete
    when "pending"
      link_to "Cancel Request", friendship_path(current_user.friendship_relation(user)), class: "btn btn-primary", method: :delete
    when "requested"
      content_tag(:div) do
        (link_to "Accept", accept_friendship_path(current_user.friendship_relation(user)), class: "", method: :put) +
        (link_to "Delete", friendship_path(current_user.friendship_relation(user)), class: "", method: :delete).html_safe
      end
    when "not_friends"
      link_to "Add Friend", friendships_path(user_id: user), class: "btn btn-primary", method: :post
    end
  end

end
