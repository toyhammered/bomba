class Api::V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at, :up_votes, :down_votes, :total_votes


    def up_votes
      post = Post.find(id)
      post.get_likes.size
    end

    def down_votes
      post = Post.find(id)
      post.get_dislikes.size
    end

    def total_votes
      (up_votes - down_votes)
    end
end
