class JoinGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:index, :create, :new, :destroy, :edit, :update]
  before_action :set_user, only: [:new, :destroy, :edit, :update, :create]
  before_action :set_join_group, only: [:new, :destroy, :edit, :update, :create]

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
    respond_to do |format|
      if @join_group && @join_group.save
        format.html { redirect_to group_posts_path(@group), notice: 'Welcome!' }
      else
        format.js { flash[:warning] = "The username already exist" }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def update
    respond_to do |format|
      if @join_group.update(join_group_params)
        format.html { redirect_to group_posts_path(@group), notice: 'Username updated successfuly' }
      else
        format.js { flash[:warning] = "The username already exist." }
      end
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_user
    @user = current_user
  end

  def set_join_group
    @join_group = @group.join_groups.find_by(user_id: @user)
  end

  def join_group_params
    params.require(:join_group).permit(:username, :avatar)
  end

end
