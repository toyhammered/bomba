class ActivitiesContainer extends React.Component {

  propTypes: {
    friends: React.PropTypes.array,
    current_user: React.PropTypes.object,
    form_token: React.PropTypes.string
  }

  constructor(props) {
    super(props);
    // Bind callback methods to make `this` the correct context.
    this.onChange = this.onChange.bind(this);
  }

  componentWillMount() {
    PostStore.listen(this.onChange);
    var friends = this.props.friends
    var user = this.props.current_user
    PostActions.getActivityPosts(friends, user);
    var polling = setInterval(function() {PostActions.getActivityPosts(friends, user);}, 10000);

  }

  componentWillUnmount() {
    for (var i = 1; i < 99999; i++) {
      window.clearInterval(i);
    }
    PostStore.unlisten(this.onChange);
  }

  onChange(state) {
    this.setState(state);
  }

  render() {
    return (
      <Posts
        posts={this.state.posts}
        current_user={this.props.current_user}
        comment_authenticity_token={this.props.form_token}
      />
    );

  }
}
