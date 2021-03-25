class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :set_group_artists
  before_action :set_joined_groups
  before_action :set_other_groups

  def index
  end

  
  def show
    respond_to do |format|
      format.html
    end
  end

  def edit 
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  def update
    binding.pry
    respond_to do |format|
      if @group.update(group_params)
        if @user.Admin?
          format.html { redirect_to edit_group_path(@group), notice: 'Username updated successfuly' }
        else
          format.html { redirect_to group_posts_path(@group), notice: 'Username updated successfuly' }
        end
      else
        format.js { flash[:warning] = "The username already exist." }
      end
    end
  end

  private
  def set_group
    @group = Group.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def group_params
    params.require(:group).permit(:name, :avatar)
  end

  def set_group_artists
    @group_artists = JoinGroup.where(group_id: @group.id).joins(:user).where(users: {type_user: 0})
  end

  def set_joined_groups
    @joined_groups = Group.includes(:join_groups).where(id: JoinGroup.select(:group_id).where(user_id: @user))
  end

  def set_other_groups
    @other_groups = Group.includes(:join_groups).where.not(id: JoinGroup.select(:group_id).where(user_id: @user))
  end

end
