var PostForm = React.createClass({
  displayName: 'PostForm',

  propTypes: {
    user: React.PropTypes.object,
    avatar: React.PropTypes.string,
    authenticity_token: React.PropTypes.string
  },

  render: function() {
    return (
      <form className="new_post" id="new_post" action="/posts" acceptCharset="UTF-8" method="post">
        <input name="utf8" type="hidden" value="&#x2713;" />
        <input type='hidden' name='authenticity_token' value={this.props.authenticity_token} />
        <div className="row">
          <div className="col-md-offset-1">
            <div className="panel panel-inverse panel-post">
              <img src={this.props.avatar} />
              <div className="panel-body panel-body-inverse">
                <textarea rows="4" className="form-control" placeholder="" name="post[body]" id="post_body"></textarea>
              </div>
            </div>
            <div className="panel-footer panel-footer-inverse panel-footer-form">
              <input type="submit" name="commit" value="Post" className="btn btn-primary" />
            </div>
          </div>
        </div>
      </form>
    );
  }
});
