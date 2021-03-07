class JoinGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:index, :create, :new, :destroy, :edit, :update]
  before_action :set_user, only: [:new, :destroy, :edit, :update, :create]

  def new
    @title = "You havent join this"
    @join_group = @group.join_groups.build
    @user = current_user
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  def create
    unless find_username
      @join_group = @group.join_groups.build(join_group_params)
      @join_group.user_id = current_user.id
    end
    respond_to do |format|
      if @join_group.save
        format.html { redirect_to group_posts_path(@group), notice: 'Post was successfully created.' }
        format.json { render :index, status: :created, location: @join_group }
      else
        format.html { redirect_to group_posts_path(@group), alert: 'Failed to create post.' }
      end
    end
  end

  def find_username
    set_group
    set_user
    unless @group.join_groups.build(join_group_params).unique?(params[:join_group][:username], @group).unique?(@user, @group)
      respond_to :js
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_user
    @user = current_user
  end

  def join_group_params
    params.require(:join_group).permit(:username)
  end

  def unique
    set_group
    set_user
    @group.join_groups.build(join_group_params).unique?(params[:join_group][:username], @group).unique?(@user, @group)
  end  
end
