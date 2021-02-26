class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum type_user: [:Artist, :User]

  has_many :posts
  has_many :comments
  has_many :likes
  has_many :join_groups
  has_many :groups, through: :join_groups

  has_one_attached :avatar


  def likes?(post)
    post.likes.where(user_id: id).any?
  end
end
