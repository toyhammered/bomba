class Api::V1::UsersController < Api::V1::ApiController

  # this is for searchbar
  def index
    @users = User.where(['username LIKE ? OR email LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%"]).limit(5)
    render json: @users, each_serializer: Api::V1::UserSerializer
  end

end
