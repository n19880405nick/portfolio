class Tag < ApplicationRecord
  has_many :post_tags
  has_many :post, through: :post_tags
end
