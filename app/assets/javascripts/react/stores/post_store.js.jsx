(() => {
  class PostStore {
    constructor() {
      console.log("PostStore getState() called");
      this.posts = [];
      this.bindListeners({
        handleUpdatePosts: PostActions.UPDATE_POSTS,
      });
    }

    handleUpdatePosts(posts) {
      console.log("handleUpdatePosts() called");
      this.posts = posts;
    }
  }

  this.PostStore = alt.createStore(PostStore, 'PostStore');
})();
