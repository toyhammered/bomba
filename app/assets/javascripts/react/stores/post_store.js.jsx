class PostStore {
  constructor() {
    this.bindListeners({
      onSubmitPost:         PostActions.submitPost,
      onSubmitComment:      PostActions.submitComment,
      onGetPosts:           PostActions.getPosts,
      onUpdatePosts:        PostActions.updatePosts
    });
    this.state = {
      posts:          []
      // user:           false,
      // current_user:   false,
      // page:           false,
      // form_token:     false
    }

  }

  onUpdatePosts(posts) {
    this.posts = posts
  }

  onGetPosts(params) {
    fetch(`/api/v1/posts.json?user_id=${params.user}&page=${params.page}`).then(
      (response) => {
        return response.json();
    }).then(
      (data) => {
      console.log("****Fetch Response****", data.posts);
      this.setState({posts: data.posts});
    }).catch(
      (errorMessage) => {
        console.log("Something went wrong!", `error: ${errorMessage}`);
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
