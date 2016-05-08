class Api::V1::ActivitiesController < Api::V1::ApiController

  def index
    # page = params[:page].present? ? params[:page] : 1
    all_users = params[:all_users].split(',');
    all_posts = [];
    all_users.each do |user|
      all_posts.push(Post.where(user_id: user))
    end

    render json: all_posts.flatten.sort_by {|u| u.created_at }.last(10).reverse
  end

end
