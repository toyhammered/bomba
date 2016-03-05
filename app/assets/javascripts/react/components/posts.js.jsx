var Posts = React.createClass({
  propTypes: {
    posts: React.PropTypes.array,
    posts_path: React.PropTypes.string,
    user: React.PropTypes.object,
    current_user: React.PropTypes.object,
    comment_authenticity_token: React.PropTypes.string
  },

  render: function() {
    var user = this.props.user;
    var current_user = this.props.current_user;
    var posts_path = this.props.posts_path;
    var comment_authenticity_token = this.props.comment_authenticity_token;

    var createPost = (post) => <Post key={post.id}
                                     post={post}
                                     user={user}
                                     current_user={current_user}
                                     posts_path={posts_path}
                                     comment_authenticity_token={comment_authenticity_token} />;


    return (
        <div>{this.props.posts.map(createPost)}</div>
    );
  }
});
