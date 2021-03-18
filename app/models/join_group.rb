class JoinGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  has_one_attached :avatar, dependent: :destroy

  def unique?(username, group)
    nickname = username.scan(/\w+/).to_sentence
    all_username = []
    JoinGroup.where(group_id: group.id).each do |join|
      all_username << join.username
    end
    all_username.include?(nickname)
  end

end
