var CommentsContainer = React.createClass({
  propTypes: {
    comments: React.PropTypes.string,
    postId: React.PropTypes.number
  },

  componentWillMount: function() {
    this.fetchComments();
    {/* setInterval(this.fetchComments, 1000); */}
  },

  fetchComments: function() {
    $.getJSON(
      (this.props.comments + "/" + this.props.postId + "/comments"),
      (data) => this.setState({comments: data.comments})
    );
  },

  getInitialState: function() {
    return { comments: [] };
  },

  render: function() {
    return (
      <Comments
        comments={this.state.comments}
      />
    );
  }
});
