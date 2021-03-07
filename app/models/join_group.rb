class JoinGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  def unique?(username, group)
    binding.pry
    nickname = username.scan(/\w+/)
    all_username = []
    JoinGroup.where(group_id: group.id).each do |join|
      all_username << join.username
    end
    all_username.include?(nickname)
  end

end
