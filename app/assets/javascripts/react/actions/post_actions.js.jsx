(() => {
  class PostActions {
    constructor() {
      this.generateActions(
        'initData',
        'submitPost'
      )
    }
  }

  this.PostActions = alt.createActions(PostActions);
})();
