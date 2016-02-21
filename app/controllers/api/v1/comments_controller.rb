class Api::V1::CommentsController < Api::V1::ApiController

  def index
    post = Post.find(params[:post_id])
    comments = post.comments

    render json: comments
  end
end
