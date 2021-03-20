class FrontPagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @user = current_user
    @title = "You havent join this group"
    @groups = Group.all
    @joined_groups = Group.includes(:join_groups).where(id: JoinGroup.select(:group_id).where(user_id: @user))
    @other_groups = Group.includes(:join_groups).where.not(id: JoinGroup.select(:group_id).where(user_id: @user))
    
    # respond_to do |format|
    #   format.html { render "layouts/toggle_sidebar" }
    # end
  end

  private
  def set_user
    @user = current_user
  end
end
