class JoinGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:index, :create, :new, :destroy, :edit, :update]
  before_action :set_user, only: [:new, :destroy, :edit, :update, :create]

  def new
    @title = "You havent join this group"
    @join_group = @group.join_groups.build
    respond_to do |format|
      # format.html 
      format.js { render layout: false }
    end
  end

  def create
    
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_user
    @user = current_user
  end

  def join_group_params
    params.require(:join_group).permit(:join_group)
  end
end
