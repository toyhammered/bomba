class PostsContainer extends React.Component {

  propTypes: {
    user: React.PropTypes.object,
    current_user: React.PropTypes.object,
    form_token: React.PropTypes.string,
    page: React.PropTypes.string
  }

  constructor(props) {
    super(props);
    // Bind callback methods to make `this` the correct context.
    this.onChange = this.onChange.bind(this);
  }

  componentWillMount() {
    PostStore.listen(this.onChange)
    PostActions.getPosts(this.props.user.id, this.props.page)
  }

  componentWillUnmount() {
    PostStore.unlisten(this.onChange);
  }

  onChange(state) {
    console.log("onChange called!", state);
    this.setState(state);
  }

  render() {
    console.log("*****post state*****", this.state);
    return (
      <Posts
        posts={this.state.posts}
        current_user={this.props.current_user}
        comment_authenticity_token={this.props.form_token}
      />
    );

  }
}
