$(document).on('page:change', function() {

  $(function() {
    setTimeout(function() {
      $('.alert').fadeOut(300);
    }, 2000);
  });


    $('#the-basics .typeahead').typeahead({
      hint: true,
      highlight: true,
      minLength: 1,
    },

    {
        name: 'usernames',
        displayKey: 'usernames',
        source: function(query, syncResults, asyncResults) {
          objects = [];
          map = {};

          $.ajax({
            type: "GET",
            url: "/users/search",
            dataType: "json",
            data: {query: query}
          }).done(function(data){
            $.each(data, function(i, data1){
              $.each(data1, function(i, object){
                console.log("Map: ", map);
                map[object.email] = object;
                objects.push({id: object.id, email: object.email, username: object.username, avatar: object.avatar})
              }); // second each
            }); // first each
            console.log("Results: ", objects);
            asyncResults(objects);
          });
        },
        templates: {
          empty: [
            '<div class="empty-message">',
            'No username or email matches found.',
            '</div>'
          ].join('\n'),
          suggestion: function(user) {
            console.log("******");
            console.log(user);
            var itm = ''
            + "<a href='/users/" + user.username + "'>"
              + "<div class='typeahead_wrapper'>"
                + "<img class='typeahead_photo' src='" + user.avatar.avatar["comment_avatar"].url + "'/>"
                + "<div class='typeahead_labels'>"
                  + "<div>" + user.username + "</div>"
                + "</div>"
              + "</div>"
            + "</a>";
            return itm;
          }
        }
    });

}); // end of document page change
