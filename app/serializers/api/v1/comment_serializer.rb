class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at, :user
  
  def user
    User.find(object.user)
  end

end
