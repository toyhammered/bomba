class Api::V1::VoteSerializer < ActiveModel::Serializer
  attributes :id, :votable, :votable_type, :voter, :vote_flag, :vote_scope, :vote_weight, :created_at, :updated_at
end
