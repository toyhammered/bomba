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

          $.ajax({
            type: "GET",
            url: "/api/v1/users",
            dataType: "json",
            data: {query: query}
          }).done(function(data){
            asyncResults(data.users);
          });
        },
        templates: {
          empty: [
            '<div class="empty-message">',
            'No username or email matches found.',
            '</div>'
          ].join('\n'),
          suggestion: function(user) {
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
