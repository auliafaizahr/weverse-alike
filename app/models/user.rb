class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments
  has_many :likes

  has_one_attached :avatar

  enum type_user: [:Artist, :User]

  def likes?(post)
    post.likes.where(user_id: id).any?
  end

  # def comment_likes?(comment)
  #   post.likes.where(user_id: id).any?
  # end
end
