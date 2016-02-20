var Comments = React.createClass({
  propTypes: {
    comments: React.PropTypes.object
  },
  
  render: function() {
    return <div>{this.props.comments}</div>;
  }
});
