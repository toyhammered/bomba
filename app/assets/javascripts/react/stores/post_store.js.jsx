class PostStore {
  constructor() {
    this.bindListeners({
      onSubmitPost:         PostActions.submitPost,
      onSubmitComment:      PostActions.submitComment,
      onGetPosts:           PostActions.getPosts,
      onDeletePost:         PostActions.deletePost
    });
    this.state = {
      posts:          []
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
    const url = '/api/v1/posts';
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
      let postStateCopy = this.state.posts;
      postStateCopy.unshift(data.post);
      this.setState({posts: postStateCopy});
    }).catch((errorMessage) => {
      console.log('Something went wrong!', `error: ${errorMessage}`);
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
      let postStateCopy = this.state.posts;
      postStateCopy.find(post => post.id == post_id).comments.unshift(data.comment);
      this.setState({posts: postStateCopy});
    }).catch((errorMessage) => {
      console.log('Something went wrong!', `error: ${errorMessage}`);
    });
  }

  onDeletePost(data) {
    const post_id = data.post.id;
    const url = `/api/v1/posts/${post_id}`;
    fetch(url, {
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      method: 'DELETE',
      body: JSON.stringify(data)
    }).then((response) => {
      return response.json();
    }).then((data) => {
      let postStateCopy = this.state.posts;
      postIndex = postStateCopy.findIndex(post => post.id == post_id);
      postStateCopy.splice(postIndex, 1);
      this.setState({posts: postStateCopy});
    }).catch((errorMessage) => {
      console.log('Something went wrong!', `error: ${errorMessage}`);
    });
  }

}

this.PostStore = alt.createStore(PostStore, 'PostStore');
