class Api::V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at
end
