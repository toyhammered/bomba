class Api::V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at, :user, :up_votes, :down_votes, :total_votes, :voted_for
  has_many :votes
  has_many :comments

  def voted_for
    object.voted_for(serialization_options[:current_user])
  end
end
