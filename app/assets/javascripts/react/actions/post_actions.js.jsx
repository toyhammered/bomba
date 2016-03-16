class PostActions {
  getPosts(user, page) {
    return {
      user: user,
      page: page
    };
  }

  updatePosts() {

  }

  submitPost() {

  }

  submitComment() {

  }

}

this.PostActions = alt.createActions(PostActions);
