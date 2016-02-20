var PostsContainer = React.createClass({
  /*
    We need to get the posts as JSON.
    This will be implemented after I have everything working without AJAX

    componentWillMount() {
      this.fetchPosts();
      setInterval(this.fetchPosts, 1000);
    },

    fetchPosts() {
      test = $.getJSON(
        this.props.postsPath,
        (data) => this.setState({posts: data})
      );
    },

    getInitialState() {
      return { posts: [] };
    },
  */

  render: function() {
    return <Posts posts={this.props.posts}
                  user={this.props.user}
                  current_user={this.props.current_user}
                  comment_authenticity_token={this.props.comment_authenticity_token}
            />;
  }
});
