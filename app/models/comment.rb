class Comment < ActiveRecord::Base
  acts_as_votable
  default_scope { order(created_at: :desc)}

  belongs_to :post
  belongs_to :user

  validates :body, presence: true
  validates :post, presence: true
  validates :user, presence: true
end
