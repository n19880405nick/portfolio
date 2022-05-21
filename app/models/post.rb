class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :tags, through: :post_tags

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
