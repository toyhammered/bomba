var Post = React.createClass({
  displayName: 'Post',

  propTypes: {
    user: React.PropTypes.object,
    avatar: React.PropTypes.string,
    post: React.PropTypes.object
  },

  render: function() {
    return (
      <div className="row">
        <div className="col-md-offset-1">
          <div className="panel panel-inverse panel-post">
            <img src={this.props.avatar} />

            <div className="panel-heading panel-heading-inverse">
              {/* link_to user.username, user_path(user.username)  link_to "posted this #{time_ago_in_words(post.created_at)} ago", post_path(post) */}
              <div className="dropdown pull-right">
                <a href="#" className="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i className="fa fa-2x fa-cog"></i></a>
                <ul className="dropdown-menu">
                  {/* }<li> link_to "Edit Post", "#", "data-target": "#myModal_#{post.id}", "data-toggle": "modal" </li> */}
                  {/* }<li>link_to "Delete Post", post_path(post), method: :delete, className: 'navbar-link', data: {confirm: "Are you sure?"}</li> */}
                </ul>
              </div>
            </div>

            <div className="panel-body panel-body-inverse panel-body-post">
              <div className="text-area">
                {this.props.post.body}
              </div>
            </div>
          </div>

          {/* }
          <div class="panel-footer panel-footer-inverse panel-footer-post">
            <%= link_to "<i class='fa fa-2x fa-heart'></i>".html_safe, like_post_path(post), method: :put %>
            <%= post.get_likes.size - post.get_dislikes.size %>
            <%= link_to "<i class='fa fa-2x fa-bomb'></i>".html_safe, dislike_post_path(post), method: :put %>
          </div>
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
              {/* <%= render partial: 'comments/form', locals: {post: post, user: current_user} %> */}
                {Object.keys(this.props.comments).map(function(comment){
                  {/* some issue with the looping */}
                  return <Comment comment={comment[0]}/>;

                }.bind(this))
                }

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
