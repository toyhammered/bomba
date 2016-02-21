var Comment = React.createClass({
  propTypes: {
    key: React.PropTypes.number,
    comment: React.PropTypes.object,
    user: React.PropTypes.array,
  },

  render: function() {
    return (
      <div className="row">
          <div className="panel panel-inverse panel-comment">
            <div className="panel-body panel-body-inverse">
              {/* <%= image_tag(user.avatar.comment_avatar) %> */}

              <div className="panel-comment-text">
                  <p>
                    {/*  <%= link_to user.username, user_path(user.username) %> <%= comment.body %> */}
                  </p>
                  <small>
                  {/*
                      <%=link_to "<i className='fa fa-heart'></i>".html_safe, like_comment_path(comment), method: :put %>
                      <%=link_to "<i className='fa fa-bomb'></i>".html_safe, dislike_comment_path(comment), method: :put %>
                      <%= time_ago_in_words(comment.created_at) %> ago. | <%= comment.get_likes.size %> likes | <%= comment.get_dislikes.size %> bombs
                  */}
                  </small>
              </div>
            </div>
          </div>
      </div>
    );
  }
});
