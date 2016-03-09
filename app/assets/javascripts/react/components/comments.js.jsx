var Comments = React.createClass({
  propTypes: {
    post: React.PropTypes.object
  },

  render: function() {

    var createComment = (comment) => <Comment key={comment.id}
                                              comment={comment} />;

    return (
      <div>{this.props.post.comments.map(createComment)}</div>
    );
  }
});
