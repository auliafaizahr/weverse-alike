class JoinGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates  :username, uniqueness: { scope: :group_id }

  has_one_attached :avatar, dependent: :destroy
  has_many :posts, through: :group
end
