var UserIndex = React.createClass({
  displayName: 'UserIndex',

  propTypes: {
    user: React.PropTypes.object,
    avatar: React.PropTypes.string,
    friendship_button: React.PropTypes.string
  },

  render: function() {
    return (
      <div id={"user-" + this.props.user.id} className="col-xs-12 col-sm-6  col-md-3">
        <div className="thumbnail">
          <a href={"users/" + this.props.user.username}>
            <img src={this.props.avatar} />
            <div className="caption">
              <p className="text-center">{this.props.user.username}</p>
            </div>
          </a>
        </div>

        <div className="friendship-button text-center">
          <div dangerouslySetInnerHTML={{__html: this.props.friendship_button}} />
        </div>
      </div>
    );
  }
});
