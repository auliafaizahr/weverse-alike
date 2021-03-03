class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum type_user: [:Artist, :User]

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :join_groups, dependent: :destroy
  has_many :groups, through: :join_groups, dependent: :destroy

  has_one_attached :avatar, dependent: :destroy

  def likes?(post)
    post.likes.where(user_id: id).any?
  end

  def artist?(user)
    user.type_user == 'Artist'
  end

  scope :artist, -> { where("type_user = 0")}
end
