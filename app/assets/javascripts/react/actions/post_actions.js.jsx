(() => {
  class PostActions {
    constructor() {
      this.generateActions(
        'initData',
        'submitPost',
        'submitComment'
      )
      console.log(this.generateActions)
    }
  }

  this.PostActions = alt.createActions(PostActions);
})();
