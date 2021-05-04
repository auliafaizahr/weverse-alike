class FrontPagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @user = current_user
    @group = @user.groups.first
    @title = "You havent join this group"
    @groups = Group.all.order("id ASC").includes(avatar_attachment: :blob)
    @joined_groups = Group.where(id: JoinGroup.select(:group_id).where(user_id: @user))
    @other_groups = Group.where.not(id: JoinGroup.select(:group_id).where(user_id: @user))
    respond_to do |format|
      if @user.Artist?
        format.html { redirect_to group_posts_path(@group), alert: 'You cant access this page' }
      else
        format.html
      end
    end
  end

  private
  def set_user
    @user = current_user
  end
end
