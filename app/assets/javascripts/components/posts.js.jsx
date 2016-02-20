var Posts = React.createClass({
  propTypes: {
    posts: React.PropTypes.array,
    user: React.PropTypes.object,
    current_user: React.PropTypes.object,
    comment_authenticity_token: React.PropTypes.string
  },

  render: function() {
    {/* Still a little hesitant with the Arrow Functions in ES6 */}
    {/* Would love to figure out how to pass the entire mapped object, instead of just body */}
    var createPost = ({body, id, created_at}) => <Post postBody={body}
                                                       postId={id}
                                                       postCreated={created_at}
                                                       user={this.props.user}
                                                       current_user={this.props.current_user}
                                                       comment_authenticity_token={this.props.comment_authenticity_token}
                                                    />;
    return (
        <div>{this.props.posts.map(createPost)}</div>
    );
  }
});
