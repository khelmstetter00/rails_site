class Micropost < ActiveRecord::Base
  attr_accessible :title, :content
  belongs_to :user

  validates :title, presence: true, length: { minimum: 4, maximum: 70 }
  validates :content, presence: true
  validates :user_id, presence: true

  has_many :comments, dependent: :destroy

  default_scope order: 'microposts.created_at DESC'

  def self.from_users_followed_by(user)
  	followed_user_ids = "SELECT followed_id FROM relationships
  						 WHERE follower_id = :user_id"
  	where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user)
  end
end
