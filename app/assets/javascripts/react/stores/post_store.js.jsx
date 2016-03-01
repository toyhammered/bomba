(() => {
  class PostStore {
    constructor() {
      this.posts = [];
      this.bindListeners({
        handleUpdatePosts: PostActions.UPDATE_POSTS
      });
    }

    handleUpdatePosts(posts) {
      this.posts = posts;
    }
  }

  this.PostStore = alt.createStore(PostStore, 'PostStore');
})();
