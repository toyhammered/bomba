module UsersHelper

  def profile_friendship_button(user)
    # no button required for yourself
    return if current_user == user

    # friendships = Friendship.active_for(user)
    # pending_friendships = PendingFriendship.pending_for(user)
    friendships = Friendship.where(user_id: [current_user, user], friend_id: [current_user, user])
    pending_friendships = PendingFriendship.where(user_id: [current_user, user], friend_id: [current_user, user])

    if friendships.empty? && pending_friendships.empty?
      link_to "Add Friend", pending_friendships_path(user_id: user), class: "btn btn-primary", method: :post
    elsif friendships.present?
      link_to "Remove Friend", friendship_path(friendships.take.id), class: "btn btn-primary", method: :delete
    elsif pending_friendships.take && pending_friendships.take.user == current_user
      link_to "Cancel Request", pending_friendship_path(pending_friendships.take.id), class: "btn btn-primary", method: :delete
    else
      content_tag(:div, class: "requested-friends-helper") do
        (link_to "<i class='fa fa-2x fa-check'></i>".html_safe, accept_pending_friendship_path(pending_friendships.take.id), class: "", method: :post) +
        (link_to "<i class='fa fa-2x fa-times'></i>".html_safe, pending_friendship_path(pending_friendships.take.id), class: "", method: :delete).html_safe
      end
    end

  end

end
