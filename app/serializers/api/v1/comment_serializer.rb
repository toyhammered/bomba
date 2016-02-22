class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at, :user, :up_votes, :down_votes, :total_votes

  def user
    User.find(object.user)
  end

  def up_votes
    comment = Comment.find(id)
    comment.get_likes.size
  end

  def down_votes
    comment = Comment.find(id)
    comment.get_dislikes.size
  end

  def total_votes
    (up_votes - down_votes)
  end

end
