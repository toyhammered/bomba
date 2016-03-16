class PostActions {
  getPosts(user, page) {
    return {
      user: user,
      page: page
    };
  }

  updatePosts() {

  }

  submitPost(data) {
    return data
  }

  submitComment() {

  }

}

this.PostActions = alt.createActions(PostActions);
