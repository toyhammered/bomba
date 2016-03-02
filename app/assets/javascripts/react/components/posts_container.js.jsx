
class PostsContainer extends React.Component {

  propTypes: {
    user: React.PropTypes.object,
    current_user: React.PropTypes.object,
    comment_authenticity_token: React.PropTypes.string
  }

  constructor(props) {
    super();

    this.state = {
      user: props.user,
      current_user: props.current_user,
      posts: PostStore.getState().posts
    }
    this.fetchPosts();
    // setInterval(this.fetchPosts, 10000);
  }

  componentWillMount() {
    PostStore.listen(this.handleViewChange);
  }

  componentWillUnmount() {
    PostStore.unlisten(this.handleViewChange);
  }

  handleViewChange(state) {
    console.log("handleViewChange() called");
    this.setState(state);
  }

  fetchPosts() {
    console.log("FetchPosts()", this.state);

    $.getJSON(
      "/api/v1/posts",
      {
        user_id: this.state.user.id
      },
      (data) => this.setState({
                                posts: data.posts
                              })

    );
  }

  render() {
    return (
      <Posts
        posts={this.state.posts}
        posts_path="/api/v1/posts"
        user={this.state.user}
        current_user={this.state.current_user}
        comment_authenticity_token={this.props.comment_authenticity_token}
      />
    );

  }
}
