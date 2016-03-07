(() => {
  class PostStore {
    constructor() {
      console.log("PostStore getState() called");

      this.bindActions(PostActions)
      this.posts = [];

      this.exportPublicMethods(
        {
        getPosts: this.getPosts
        }
      )
    }

    onInitData(props) {
      this.user = props.user;
      this.current_user = props.current_user;
      this.page = props.page;
    }

    getPosts() {
      this.getState().posts
    }

    onSubmitPost(data) {
      $.ajax({
        type: "POST",
        url: "/api/v1/posts",
        data: data,
      })
      .done(function(response){
        console.log("Completed sending post");
        console.log(response);
        this.posts.push(response);
        this.emitChange();
      })
      .error(function(response){
        console.log('error');
        console.log(response);
      });
    }

  }

  this.PostStore = alt.createStore(PostStore, 'PostStore');
})();
