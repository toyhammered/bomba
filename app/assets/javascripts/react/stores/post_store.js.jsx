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
      console.log("onInitData() called");
      this.user = props.user;
      this.current_user = props.current_user;
      this.page = props.page;
    }

    getPosts() {
      this.getState().posts
    }

  }

  this.PostStore = alt.createStore(PostStore, 'PostStore');
})();
