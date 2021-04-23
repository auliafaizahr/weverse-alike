class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :likes, as: :likeable
  validates :comment, presence: true, allow_blank: false
end
