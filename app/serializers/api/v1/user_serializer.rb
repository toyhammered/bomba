class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :role, :avatar
end
