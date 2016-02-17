var Comment = React.createClass({
  propTypes: {

  },

  render: function() {
    return (
      <div>
        <div> Actual Comment </div>
        <div>{this.props.comment.body}</div>
      </div>
    );
  }
});
