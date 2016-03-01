class PostsContainer extends React.Component {
  propTypes: {
    posts: React.PropTypes.string,
    user: React.PropTypes.object,
    current_user: React.PropTypes.object,
    comment_authenticity_token: React.PropTypes.string
  }

  constructor() {
    super();
    this.state = PostStore.getState();

    this.handleViewChange = (state) => {
      this.setState(state);
    }
  }

  componentWillMount() {
    PostStore.listen(this.handleViewChange);
    this.fetchPosts();
    {/* setInterval(this.fetchPosts, 20000); */}
  }

  componentWillUnmount() {
    PostStore.unlisten(this.handleViewChange);
  }

  fetchPosts() {
    $.getJSON(
      this.props.posts,
      {
        user_id: this.props.user.id
      },
      (data) => this.setState({posts: data.posts})

    );
  }

  render() {
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
}
