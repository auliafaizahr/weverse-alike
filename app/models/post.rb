class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group

  has_many_attached :images, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :post_attachments, dependent: :destroy
  accepts_nested_attributes_for :post_attachments
end
