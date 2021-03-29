class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_authenticate
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
      if admin_authenticate
        format.html
      else
        format.html { redirect_to root_path, alert: 'You cant access this page' }
      end
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
  def admin_authenticate
    current_user.Admin?
  end
end
