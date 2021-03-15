class MediaVideo < ApplicationRecord
  belongs_to :group
  belongs_to :media_video_category

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
end
