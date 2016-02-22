var Comment = React.createClass({
  propTypes: {
    key: React.PropTypes.number,
    comment: React.PropTypes.object
  },

  render: function() {
    return (
      <div className="row">
          <div className="panel panel-inverse panel-comment">
            <div className="panel-body panel-body-inverse">
              <img src={this.props.comment.user.avatar.comment_avatar.url} />

              <div className="panel-comment-text">
                  <p>
                    <a href={"/users/" + this.props.comment.user.username} >{this.props.comment.user.username} </a>
                    {this.props.comment.body}
                  </p>

                  <small>
                    <a rel="nofollow" data-method="put" href={"/comments/" + this.props.comment.id + "/like"} >
                      <i className="fa fa-heart"></i>
                    </a>
                    <a rel="nofollow" data-method="put" href={"/comments/" + this.props.comment.id + "/dislike"} >
                      <i className="fa fa-bomb"></i>
                    </a>

                    {$.timeago(this.props.comment.created_at)}. | {this.props.comment.up_votes} likes | {this.props.comment.down_votes} bombs
                  </small>

              </div>
            </div>
          </div>
      </div>
    );
  }
});
