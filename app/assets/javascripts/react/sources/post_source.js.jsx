var PostSource = {

  fetchPosts: function(user, page) {
    console.log("******");
    console.log(user, page);

    // return $.getJSON(
    //   "/api/v1/posts",
    //   {
    //     user_id: user,
    //     page: page
    //   },
    //   (data) => {
    //     return data
    //   }
    // )
    var headers = {
      method: "POST",
      mode: 'cors',
      cache: 'default'
    };

    fetch("/api/v1/posts?user_id=" + user + "&page=" + page, headers)
    .then(function(response){
      return new Promise(function (resolve, reject) {
        setTimeout(function() {
          console.log("Fetched Data");
          console.log(response);
          resolve(response);
        }, 250);
      });
    });
  } // end of fetch function

};
