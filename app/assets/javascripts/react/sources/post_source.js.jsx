var PostSource = {

  fetchPosts: function(user, page) {
    console.log("******");
    console.log(user, page);

    fetch(`/api/v1/posts.json?user_id=${user}&page=${page}`).then(
      (response) => {
        console.log(response);
    }).catch(
      (errorMessage) => {
        console.log("Returned Promise?");
        console.log(errorMessage);
    });
  } // end of fetch function

};
