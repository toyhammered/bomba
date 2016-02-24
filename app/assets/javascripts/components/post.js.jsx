var Post = React.createClass({
  propTypes: {
    key: React.PropTypes.number,
    post: React.PropTypes.object,
    user: React.PropTypes.object,
    current_user: React.PropTypes.object,
    posts_path: React.PropTypes.string,
    comment_authenticity_token: React.PropTypes.string
  },

  render: function() {
    return (
      <div className="row">
        <div className="col-md-offset-1">
          <div className="panel panel-inverse panel-post">
            <img src={this.props.user.avatar.post_avatar.url} />

            <div className="panel-heading panel-heading-inverse">
              <a href={"/users/" + this.props.user.username} >{this.props.user.username} </a>
              <a href={"/posts/" + this.props.post.id} >posted this {$.timeago(this.props.post.created_at)} </a>

              <div className="dropdown pull-right">
                <a href="#" className="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i className="fa fa-2x fa-cog"></i></a>
                <ul className="dropdown-menu">
                  {/* }<li> link_to "Edit Post", "#", "data-target": "#myModal_#{post.id}", "data-toggle": "modal" </li> */}
                  <li><a className="navbar-link" data-confirm="Are you sure?" rel="nofollow" data-method="delete" href={"/posts/" + this.props.post.id}>Delete Post</a></li>
                </ul>
              </div>
            </div>

            <div className="panel-body panel-body-inverse panel-body-post">
              <div className="text-area post-body">
                {this.props.post.body}
              </div>
            </div>
          </div>

          <div className="panel-footer panel-footer-inverse panel-footer-post">
            <a rel="nofollow" data-method="put" href={"/posts/" + this.props.post.id + "/like"}><i className="fa fa-2x fa-heart"></i></a>
            {this.props.post.total_votes}
            <a rel="nofollow" data-method="put" href={"/posts/" + this.props.post.id + "/dislike"}><i className="fa fa-2x fa-bomb"></i></a>
          </div>

          {/*
            <%= link_to "<i class='fa fa-2x fa-heart'></i>".html_safe, like_post_path(post), method: :put %>
            <%= post.get_likes.size - post.get_dislikes.size %>
            <%= link_to "<i class='fa fa-2x fa-bomb'></i>".html_safe, dislike_post_path(post), method: :put %>
          <div class="panel-footer panel-footer-inverse panel-footer-votes">
            <% if post.get_likes.size != 0 %>
              <p>Your post has been Liked by <%= post.get_likes.size %> people</p>
            <% end %>

            <% if post.get_dislikes.size != 0 %>
              <p>Your post has been Bombed by <%= post.get_dislikes.size %> people</p>
            <% end %>
          </div>
          */}

          <div className="panel-group panel-group-comments">
            <div className="panel-heading panel-heading-inverse">
              <CommentForm
                postId={this.props.post.id}
                current_user={this.props.current_user}
                authenticity_token={this.props.comment_authenticity_token}
              />

              <CommentsContainer
                comments={"/api/v1/posts"}
                postId = {this.props.post.id}
              />

              {/*
              <%# Some type of way to tell if it is on post show or another page %>
              <% if request.path.include?("/posts") %>
                <%= render partial: 'comments/comment', collection: post.comments %>
              <% elsif post.comments.first.present? %>
                <%= render partial: 'comments/comment', locals: {comment: post.comments.first} %>
                <% if post.comments.count > 1 %>
                  <%= link_to "see more comments", post_path(post) %>
                <% end %>
              <% end %>
              */}
            </div>
          </div>
        </div>
      </div>
    );
  }
});
