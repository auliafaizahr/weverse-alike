class JoinGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:index, :create, :new, :destroy, :edit, :update, :join_new]
  before_action :set_user, only: [:new, :destroy, :edit, :update, :create]
  before_action :set_join_group, only: [:destroy, :edit, :update]

  def new
    @title = "You havent join this"
    @user = current_user
    @joined_groups = Group.includes(:join_groups).where(id: JoinGroup.select(:group_id).where(user_id: @user))
    @other_groups = Group.includes(:join_groups).where.not(id: JoinGroup.select(:group_id).where(user_id: @user))
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  def create
    binding.pry
    check_user
    respond_to do |format|
      if @join_group.save
        if @user.Admin?
          format.html { redirect_to group_path(@group), notice: 'Username updated successfuly' }
        else
          format.html { redirect_to group_posts_path(@group), notice: 'Username updated successfuly' }
        end
      else
        format.js { flash[:warning] = "The username already exist" }
      end
    end
  end

  def edit
    @joined_groups = Group.includes(:join_groups).where(id: JoinGroup.select(:group_id).where(user_id: @user))
    @other_groups = Group.includes(:join_groups).where.not(id: JoinGroup.select(:group_id).where(user_id: @user))
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def update
    binding.pry
    respond_to do |format|
      if @join_group.update(join_group_params)
        if @user.Admin?
          format.html { redirect_to group_path(@group), notice: 'Username updated successfuly' }
        else
          format.html { redirect_to group_posts_path(@group), notice: 'Username updated successfuly' }
        end
      else
        format.js { flash[:warning] = "The username already exist." }
      end
    end
  end

  def join_new
    # @join_group = @group.join_groups.find(params[:join_group_id])
    @artists = User.artist.includes(:join_groups).where.not(id: JoinGroup.select(:user_id))
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def check_user
    if current_user.Admin?
      binding.pry
      join_group_params = params.require(:join_group).permit(:username, :avatar, :user_id)
      @join_group = @group.join_groups.build(join_group_params)
    else
      @join_group = @group.join_groups.build(join_group_params)
      @join_group.user_id = current_user.id
    end
  end

  def return_page_user
    
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_user
    @user = current_user
  end

  def set_join_group
    @join_group = @group.join_groups.find(params[:id])
  end

  def join_group_params
    params.require(:join_group).permit(:username, :avatar)
  end
end
