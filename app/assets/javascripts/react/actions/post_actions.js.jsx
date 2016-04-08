class PostActions {
  getPosts(user, page) {
    return {
      user: user,
      page: page
    };
  }

  submitPost(data) {
    return data
  }

  submitComment(data) {
    return data
  }

  deletePost(data) {
    return data
  }

}

this.PostActions = alt.createActions(PostActions);
