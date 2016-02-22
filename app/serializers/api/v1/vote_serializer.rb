class Api::V1::VoteSerializer < ActiveModel::Serializer
  attribute :id, :vote_flag, :vote_weight, :up_votes, :down_votes, :total_votes

end
