class Group < ApplicationRecord
  has_many :join_groups
  has_many :users, through: :join_groups
  has_many :posts
  has_many :media_videos
  has_many :media_video_categories

  has_one_attached :avatar
  validates :avatar, content_type: ["image/png", "image/jpeg"], size: { less_than: 1.megabytes , message: 'must be less than 2MB in size' }
end

