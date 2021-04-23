class JoinGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates  :username, uniqueness: { scope: :group_id }
  # validates  :user_id, uniqueness: { scope: :artist }

  has_one_attached :avatar, dependent: :destroy
  has_many :posts, through: :group
  
  validates :avatar, content_type: ["image/png", "image/jpeg"], size: { less_than: 1.megabytes , message: 'must be less than 2MB in size' }

end