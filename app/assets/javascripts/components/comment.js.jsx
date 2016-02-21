var Comment = React.createClass({
  propTypes: {
    key: React.PropTypes.number,
    comment: React.PropTypes.object
  },

  render: function() {
    console.log(this.props.comment);
    return (
      <div className="row">
          <div className="panel panel-inverse panel-comment">
            <div className="panel-body panel-body-inverse">
              <img src={this.props.comment.user.avatar.comment_avatar.url} />

              <div className="panel-comment-text">
                  <p>
                    <a href={this.props.comment.user.username} >{this.props.comment.user.username} </a>
                    {this.props.comment.body}
                  </p>
                  {/*

                  <small>
                      <%=link_to "<i className='fa fa-heart'></i>".html_safe, like_comment_path(comment), method: :put %>
                      <%=link_to "<i className='fa fa-bomb'></i>".html_safe, dislike_comment_path(comment), method: :put %>
                      <%= time_ago_in_words(comment.created_at) %> ago. | <%= comment.get_likes.size %> likes | <%= comment.get_dislikes.size %> bombs
                  </small>
                  */}

              </div>
            </div>
          </div>
      </div>
    );
  }
});
