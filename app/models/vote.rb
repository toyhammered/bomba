class ActsAsVotable::Vote
  has_many :activities, as: :trackable, dependent: :destroy
  # before_save :track_activity
  #
  # private
  #
  # def track_activity
  #   Activity.track(voter, self, "create")
  # rescue
  #   logger.debug("*****DEBUG*****")
  #   logger.debug("ActsAsVotable#track_activity:7, incorrect option passed")
  #   logger.debug("Trackable: #{self.inspect}, Action: create")
  # end # end track_activity

end
