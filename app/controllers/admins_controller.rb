class AdminsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_group, only: [:index, :create, :new, :destroy, :edit, :update]
  # before_action :set_post, only: [:destroy, :edit, :update]
  # before_action :check_join_group, only: [:index, :create, :new, :destroy, :edit, :update]
  # layout "layouts/home"

  def index
    @user = current_user
    @title = "You havent join this group"
    @groups = Group.all
    @joined_groups = Group.includes(:join_groups).where(id: JoinGroup.select(:group_id).where(user_id: @user))
    @other_groups = Group.includes(:join_groups).where.not(id: JoinGroup.select(:group_id).where(user_id: @user))
    respond_to do |format|
      format.html
    end
  end

  def new
    
  end

  def create
  
  end

  def update
  
  end

  def edit
  
  end

  private
end
