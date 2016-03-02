class PostForm extends React.Component {
  propTypes: {
    user: React.PropTypes.object,
    authenticity_token: React.PropTypes.string
  }

  handlePost() {
    body = $("#post_body").val();
    data = {"post": {"body": body}};
    $.ajax({
      type: "POST",
      url: "/posts",
      data: data,
    }).done(function(){
      console.log("Completed sending post");
    });
    $("#post_body").val('');
  }

  render() {
    var user = this.props.user;
    return (
      <form className="new_post" id="new_post" action="/posts" acceptCharset="UTF-8" method="post" >
        <input name="utf8" type="hidden" value="&#x2713;" />
        <input type='hidden' name='authenticity_token' value={this.props.authenticity_token} />
        <div className="row">
          <div className="col-md-offset-1">
            <div className="panel panel-inverse panel-post">
              <img src={this.props.user.avatar.post_avatar.url} />
              <div className="panel-body panel-body-inverse">
                <textarea rows="4" className="form-control" placeholder="" name="post[body]" id="post_body"></textarea>
              </div>
            </div>
            <div className="panel-footer panel-footer-inverse panel-footer-form">
              <input type="submit" name="commit" value="Post" className="btn btn-primary"  />
              <button type="button" onClick={this.handlePost} >Send</button>
            </div>
          </div>
        </div>
      </form>
    );
  }
};
