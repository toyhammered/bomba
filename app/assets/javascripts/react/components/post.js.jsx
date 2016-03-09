var Post = React.createClass({
  propTypes: {
    key: React.PropTypes.number,
    post: React.PropTypes.object,
    current_user: React.PropTypes.object,
    comment_authenticity_token: React.PropTypes.string
  },

  handleVote: function(vote_type) {
    $.ajax({
      type: "POST",
      url: "/api/v1/posts/" + this.props.post.id + "/" + vote_type,
      headers: {"X-HTTP-Method-Override": "PUT"},
      data: {"id": this.props.post.id},
    }).done(function(){
      console.log("Completed updating vote on post");
    });
  },

  render: function() {
    return (
      <div className="row">
        <div className="col-md-offset-1">
          <div className="panel panel-inverse panel-post">
            <img src={this.props.post.user.avatar.post_avatar.url} />

            <div className="panel-heading panel-heading-inverse">
              <a href={"/users/" + this.props.post.user.username} >{this.props.post.user.username} </a>
              <a href={"/posts/" + this.props.post.id} >posted this {/*$.timeago(this.props.post.created_at)*/} </a>

              <div className="dropdown pull-right">
                <a href="#" className="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i className="fa fa-2x fa-cog"></i></a>
                <ul className="dropdown-menu">
                  {/* }<li> link_to "Edit Post", "#", "data-target": "#myModal_#{post.id}", "data-toggle": "modal" </li> */}
                  <li><a className="navbar-link" data-confirm="Are you sure?" rel="nofollow" data-method="delete" href={"/api/v1/posts/" + this.props.post.id}>Delete Post</a></li>
                </ul>
              </div>
            </div>

            <div className="panel-body panel-body-inverse panel-body-post">
              <div className="text-area post-body">
                {this.props.post.body}
              </div>
            </div>
          </div>

          <div className="panel-footer panel-footer-inverse panel-footer-post">
            <a onClick={this.handleVote.bind(this, "like")}><i className="fa fa-2x fa-heart"></i></a>
            {this.props.post.total_votes}
            <a onClick={this.handleVote.bind(this, "dislike")}><i className="fa fa-2x fa-bomb"></i></a>
          </div>

          <div className="panel-group panel-group-comments">
            <div className="panel-heading panel-heading-inverse">
              <CommentForm
                post={this.props.post}
                current_user={this.props.current_user}
                authenticity_token={this.props.comment_authenticity_token}
              />
              <Comments
                post = {this.props.post}
              />

              {/*
              <%# Some type of way to tell if it is on post show or another page %>
              <% if request.path.include?("/posts") %>
                <%= render partial: 'comments/comment', collection: post.comments %>
              <% elsif post.comments.first.present? %>
                <%= render partial: 'comments/comment', locals: {comment: post.comments.first} %>
                <% if post.comments.count > 1 %>
                  <%= link_to "see more comments", post_path(post) %>
                <% end %>
              <% end %>
              */}
            </div>
          </div>
        </div>
      </div>
    );
  }
});
