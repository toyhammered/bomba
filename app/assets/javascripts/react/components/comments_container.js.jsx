class CommentsContainer extends React.Component {
  propTypes: {
    comments_path: React.PropTypes.string,
    postId: React.PropTypes.number
  }

  constructor(props) {
    super(props)
    this.onChange = this.onChange.bind(this);
  }

  componentWillMount() {
    CommentStore.listen(this.onChange)
    CommentActions.initData(this.props)
  }

  componentWillUnmount() {
    CommentStore.unlisten(this.onChange)
  }

  componentWillReceiveProps() {
  }

  onChange(state) {
    this.setState(state);
  }

  render() {

    return (
      <Comments
        comments={this.state.comments}
      />
    );
  }

}
