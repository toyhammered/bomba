(() => {
  class PostStore {
    constructor() {
      this.bindActions(PostActions)
      this.posts = [];
    }

    onInitData(props) {
      // The user needs to be constantly updated (for activity feed)
      this.user = props.user;
      this.current_user = props.current_user;
      this.page = props.page;
      this.fetchPosts();
    }

    fetchPosts() {
      console.log("*******")
      console.log(this.user);
      console.log("*******")
      $.getJSON(
        "/api/v1/posts",
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

    onSubmitComment(data) {

      $.ajax({
        type: "POST",
        url: "/api/v1/posts/" + data.post_id + "/comments",
        data: data,
      })
      .done((response) => {
        // this.posts.unshift(response.post);
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
