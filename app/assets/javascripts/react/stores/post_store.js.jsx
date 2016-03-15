(() => {
  class PostStore {
    constructor() {
      // this.bindActions(PostActions)
      this.posts = [];
      this.bindListeners({
        handleInitData: PostActions.INIT_DATA,
        handleUpdatePosts: PostActions.UPDATE_POSTS,
        handleFetchPosts: PostActions.FETCH_POSTS
      })
    }

    handleInitData(props) {
      // The user needs to be constantly updated (for activity feed)
      this.user = props.user;
      this.current_user = props.current_user;
      this.page = props.page;
      this.comment_authenticity_token = props.comment_authenticity_token;
      this.posts = PostActions.fetchPosts(this.user.id, this.page);
    }

    handleUpdatePosts(posts) {
      this.posts = posts
    }

    handleFetchPosts() {
      this.posts = [];
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
