class PostAttachment < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  belongs_to :post

  validates :avatar, file_size: { less_than: 2.megabytes }
end
