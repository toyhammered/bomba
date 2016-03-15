(() => {
  class PostActions {
    // constructor() {
    //   this.generateActions(
    //     'initData'
    //     'submitPost',
    //     'submitComment',
    //     'handleFetchPosts',
    //     'handleUpdatePosts'
    //   )
    // }

    fetchPosts(user, page) {
      return (dispatch) => {
        PostSource.fetchPosts(user, page)
          .then((response) => {
            this.handleUpdatePosts(response.posts);
          })
      }
    }

  } // end of class PostActions

  this.PostActions = alt.createActions(PostActions);
})();
