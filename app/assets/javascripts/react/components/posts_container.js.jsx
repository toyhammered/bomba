class PostsContainer extends React.Component {

  propTypes: {
    user: React.PropTypes.object,
    current_user: React.PropTypes.object,
    comment_authenticity_token: React.PropTypes.string,
    page: React.PropTypes.string,
  }

  constructor(props) {
    super(props);

    // Bind callback methods to make `this` the correct context.
    this.onChange = this.onChange.bind(this);
    // this.fetchPosts();
    // setInterval(this.fetchPosts, 10000);
  }

  componentWillMount() {
    PostStore.listen(this.onChange)
    PostActions.handleInitData(this.props)
  }

  componentWillUnmount() {
    PostStore.unlisten(this.onChange);
  }

  onChange(state) {
    this.setState(state);
  }

  render() {
    console.log("*****post state*****");
    console.log(this.state);
    return (
      <Posts
        posts={this.state.posts}
        current_user={this.state.current_user}
        comment_authenticity_token={this.props.comment_authenticity_token}
      />
    );

  }
}
