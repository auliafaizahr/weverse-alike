module PostsHelper

  def user_avatar_exist(group, user)
    JoinGroup.find_by(group_id: group, user_id: user).avatar.attached?
  end
  
  def user_avatar(group, user)
    JoinGroup.find_by(group_id: group, user_id: user)
  end
end
