class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum type_user: [:Artist, :User, :Admin]

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

  def join_group?(user, group)
    JoinGroup.where(user_id: user, group_id: group)
  end

  def nickname(user, group)
    JoinGroup.find_by(user_id: user, group_id: group).username
  end

  scope :artist, -> { where("type_user = 0")}

  scope :admin, -> { where("type_user = 2")}

  scope :join_group, -> { JoinGroup.where(user_id: current_user.id) }
end
