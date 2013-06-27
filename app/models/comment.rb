class Comment < ActiveRecord::Base
  belongs_to :micropost
  belongs_to :user 
  attr_accessible :content

  validates :content, presence: true
  validates :user_id, presence: true
end
