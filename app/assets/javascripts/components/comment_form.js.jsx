var CommentForm = React.createClass({

  propsTypes: {

  },

  render: function() {
    return (
      <div>
        <div> CommentFrom </div>
        <div>{this.props.user.username}</div>
        <div>{this.props.post.body}</div>
      </div>
    );
  }
});
