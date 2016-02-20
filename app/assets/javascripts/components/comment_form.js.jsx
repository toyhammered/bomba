var CommentForm = React.createClass({
  propTypes: {
    postId: React.PropTypes.number,
    current_user: React.PropTypes.object,
    authenticity_token: React.PropTypes.string
  },

  render: function() {
    return (
        <form className="new_comment" id="new_comment" action={"/posts/" + this.props.postId + "/comments"} acceptCharset="UTF-8" method="post">
          <input name="utf8" type="hidden" value="&#x2713;" />
          <input type="hidden" name="authenticity_token" value={this.props.authenticity_token} />
          <div className="row">
            <div className="panel panel-inverse panel-comment-form">
              <div className="panel-body panel-body-inverse">
                <div className="input-group">
                  <span className="input-group-addon" id="sizing-addon1">
                    <img src={this.props.current_user.avatar.comment_avatar.url} />
                  </span>
                  <textarea rows="1" className="form-control" placeholder="Your Comment" name="comment[body]" id="comment_body"></textarea>
                  <span className="input-group-addon">
                    <input type="submit" name="commit" value="OK" className="btn btn-sm btn-primary pull-right" />
                  </span>
                </div>
              </div>
            </div>
          </div>
        </form>
    );
  }
});
