var Comments = React.createClass({
  propTypes: {
    comments: React.PropTypes.array
  },

  render: function() {

    var createComment = (comment) => <Comment key={comment.id}
                                              comment={comment}
                                              user={comment.user} />;
    return (
      <div>{this.props.comments.map(createComment)}</div>
    );
  }
});
