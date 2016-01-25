class Comment < ActiveRecord::Base
  acts_as_votable
  
  belongs_to :post
  belongs_to :user

  validates :body, presence: true
  validates :post, presence: true
  validates :user, presence: true
end
