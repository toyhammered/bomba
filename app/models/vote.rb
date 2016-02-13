class ActsAsVotable::Vote
  has_many :activities, as: :trackable, dependent: :destroy
end
