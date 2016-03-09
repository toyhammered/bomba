class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at, :user, :up_votes, :down_votes, :total_votes
  has_many :votes
end
