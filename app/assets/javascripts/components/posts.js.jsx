var Posts = React.createClass({
  propTypes: {
    posts: React.PropTypes.array,
    user: React.PropTypes.object
  },

  render: function() {
    {/* Still a little hesitant with the Arrow Functions in ES6 */}
    {/* Would love to figure out how to pass the entire mapped object, instead of just body */}
    var createPost = ({body, id}) => <Post postBody={body} postId={id} user={this.props.user} />;
    return (
        <div>{this.props.posts.map(createPost)}</div>
    );
  }
});
