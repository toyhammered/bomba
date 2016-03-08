class PostsContainer extends React.Component {

  propTypes: {
    user: React.PropTypes.object,
    current_user: React.PropTypes.object,
    comment_authenticity_token: React.PropTypes.string,
    page: React.PropTypes.string,
    post_path: React.PropTypes.string
  }

  constructor(props) {
    super(props);

    // Bind callback methods to make `this` the correct context.
    this.fetchPosts = this.fetchPosts.bind(this);
    this.onChange = this.onChange.bind(this);
    this.fetchPosts();
    // setInterval(this.fetchPosts, 10000);
  }

  componentWillMount() {
    PostStore.listen(this.onChange)
    PostActions.initData(this.props)
  }

  componentWillUnmount() {
    PostStore.unlisten(this.onChange);
  }

  onChange(state) {
    console.log(state);
    this.setState(state);
  }

  fetchPosts() {

    $.getJSON(
      this.props.post_path,
      {
        user_id: this.props.user.id,
        page: this.props.page
      },
      (data) => {
        // this is not right.
        // combineData = this.state.posts.concat(data.posts)
        this.setState({posts: data.posts})
      });
  }

  render() {
    console.log("*****state*****");
    console.log(this.state);
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