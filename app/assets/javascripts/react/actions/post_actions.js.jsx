class PostActions {
  getPosts(user, page) {
    return {
      user: user,
      page: page
    };
  }

  newPost(data) {
    return data
  }

  newComment(data) {
    return data
  }

  deletePost(data) {
    return data
  }

  newVote(data) {
    return data
  }

  getActivityPosts(data) {
    return data
  }
}

this.PostActions = alt.createActions(PostActions);
