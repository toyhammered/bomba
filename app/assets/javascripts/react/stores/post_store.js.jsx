class PostStore {
  constructor() {
    this.bindListeners({
      onSubmitPost:         PostActions.submitPost,
      onSubmitComment:      PostActions.submitComment,
      onGetPosts:           PostActions.getPosts
    });
    this.state = {
      posts:          []
      // user:           false,
      // current_user:   false,
      // page:           false,
      // form_token:     false
    }

  }

  onGetPosts(params) {
    const url = `/api/v1/posts.json?user_id=${params.user}&page=${params.page}`;
    fetch(url).then((response) => {
      return response.json();
    }).then((data) => {
      console.log("****Fetch Response****", data.posts);
      this.setState({posts: data.posts});
    }).catch((errorMessage) => {
      console.log("Something went wrong!", `error: ${errorMessage}`);
    });
  }

  onSubmitPost(data) {
  //   console.log(JSON.stringify(data));
  //   fetch("/api/v1/posts.json",{
  //     method: 'POST',
  //     headers: {
  //       Accept: 'application/json'
  //     },
  //     body: data
  //   }).then(
  //     (response) => {
  //       return response.json();
  //   }).then(
  //     (data) => {
  //       this.state.posts.unshift(data.post);
  //       this.emitChange();
  //   }).catch(
  //     (errorMessage) => {
  //       console.log("Submitting Post Failed.", `error: ${errorMessage}`);
  //   });
  // }

    $.ajax({
      type: "POST",
      url: "/api/v1/posts",
      data: data,
    })
    .done((response) => {
      let postsCopy = this.state.posts
      postsCopy.unshift(response.post)
      this.setState({posts: postsCopy})
    })
    .error((response) => {
      console.log('post error');
      console.log(response);
    });
  }

  onSubmitComment(data) {
    const post_id = data.post_id
    const url = `/api/v1/posts/${post_id}/comments`;
    fetch(url, {
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      method: 'POST',
      body: JSON.stringify(data)
    }).then((response) => {
      return response.json();
    }).then((data) => {
      postStateCopy = this.state.posts;
      postStateCopy.find(post => post.id == post_id).comments.unshift(data.comment);
      this.setState({posts: postStateCopy});
    }).catch((errorMessage) => {
      console.log("Something went wrong!", `error: ${errorMessage}`);
    });

  //   $.ajax({
  //     type: 'POST',
  //     url: `/api/v1/posts/${data.post_id}/comments`,
  //     data: data,
  //   }).done((response) => {

  //   }).error((response) => {
  //     console.log('post error');
  //     console.log(response);
  //   });
  }

}

  this.PostStore = alt.createStore(PostStore, 'PostStore');
