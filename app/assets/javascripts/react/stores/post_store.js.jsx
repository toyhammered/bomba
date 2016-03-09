(() => {
  class PostStore {
    constructor() {
      this.bindActions(PostActions)
      this.posts = [];
    }

    onInitData(props) {
      this.user = props.user;
      this.current_user = props.current_user;
      this.page = props.page;
      this.post_path = props.post_path;
      this.fetchPosts();
    }

    fetchPosts() {
      console.log("fetchPosts() called");
      $.getJSON(
        this.post_path,
        {
          user_id: this.user.id,
          page: this.page
        },
        (data) => {
          this.setState({posts: data.posts})
        });
    }

    onSubmitPost(data) {
      $.ajax({
        type: "POST",
        url: "/api/v1/posts",
        data: data,
      })
      .done((response) => {
        this.posts.unshift(response.post);
        this.emitChange();
      })
      .error((response) => {
        console.log('post error');
        console.log(response);
      });
    }

  }

  this.PostStore = alt.createStore(PostStore, 'PostStore');
})();
