class Group < ApplicationRecord
  has_many :join_groups
  has_many :users, through: :join_groups
  has_many :posts
  has_many :media_videos
  has_many :media_video_categories

  has_one_attached :avatar
end
