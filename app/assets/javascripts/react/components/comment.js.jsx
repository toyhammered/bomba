var Comment = React.createClass({
  propTypes: {
    key: React.PropTypes.number,
    comment: React.PropTypes.object
  },

  handleVote: function(vote_type) {
    $.ajax({
      type: "POST",
      url: "/comments/" + this.props.comment.id + "/" + vote_type,
      headers: {"X-HTTP-Method-Override": "PUT"},
      data: {"id": this.props.comment.id},
    }).done(function(){
      console.log("Completed updating vote on comment");
    });
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
                    <a onClick={this.handleVote.bind(this, "like")}><i className="fa fa-heart"></i></a>
                    <a onClick={this.handleVote.bind(this, "dislike")}><i className="fa fa-bomb"></i></a>

                    {$.timeago(this.props.comment.created_at)}. | {this.props.comment.up_votes} likes | {this.props.comment.down_votes} bombs
                  </small>

              </div>
            </div>
          </div>
      </div>
    );
  }
});
