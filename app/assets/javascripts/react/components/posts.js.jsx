var Posts = React.createClass({
  propTypes: {
    posts: React.PropTypes.array,
    current_user: React.PropTypes.object,
    comment_authenticity_token: React.PropTypes.string
  },

  render: function() {
    var current_user = this.props.current_user;
    var comment_authenticity_token = this.props.comment_authenticity_token;

    var createPost = (post) => <Post key={post.id}
                                     post={post}
                                     current_user={current_user}
                                     comment_authenticity_token={comment_authenticity_token} />;


    return (
        <div>{this.props.posts.map(createPost)}</div>
    );
  }
});
