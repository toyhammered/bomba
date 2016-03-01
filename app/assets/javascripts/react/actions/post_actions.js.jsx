(() => {
  class PostActions {
    updatePosts(posts) {
      this.dispatch(posts)
    }
  }

  this.PostActions = alt.createActions(PostActions);
})();
