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
    var user = this.props.user.id
    var page = this.props.page
    PostActions.getPosts(user,page)

    var polling = setInterval(function() {PostActions.getPosts(user,page);}, 10000);
  }

  componentWillUnmount() {
    for (var i = 1; i < 99999; i++) {
      window.clearInterval(i);
    }
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
