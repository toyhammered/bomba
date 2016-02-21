var PostsContainer = React.createClass({
  propTypes: {
    posts: React.PropTypes.string,
    user: React.PropTypes.object,
    current_user: React.PropTypes.object,
    comment_authenticity_token: React.PropTypes.string
  },

  componentWillMount() {
    this.fetchPosts();
    {/* setInterval(this.fetchPosts, 1000); */}
  },

  fetchPosts() {
    $.getJSON(
      this.props.posts,
      {
        user_id: this.props.user.id
      },
      (data) => this.setState({posts: data.posts})

    );
  },

  getInitialState() {
     return { posts: [] };
  },

  render: function() {
    return (
      <Posts
        posts={this.state.posts}
        posts_path={this.props.posts}
        user={this.props.user}
        current_user={this.props.current_user}
        comment_authenticity_token={this.props.comment_authenticity_token}
      />
    );

  }
});
