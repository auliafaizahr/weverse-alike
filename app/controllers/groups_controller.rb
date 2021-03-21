class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit]
  before_action :set_user, only: [:show, :edit]

  def index
  end

  
  def show
    respond_to do |format|
      format.html
    end
  end

  def edit
    @group_artists = JoinGroup.where(group_id: @group.id).joins(:user).where(users: {type_user: 0})
    respond_to do |format|
      format.html
    end
  end

  def update
    
  end

  # def create
  #   @post = @group.posts.new(post_params)
  #   respond_to do |format|
  #     if @post.save
  #       format.html { redirect_to root_path, notice: 'Tweet was successfully created.' }
  #       format.json { render :index, status: :created, location: @post }
  #     else
  #       format.html { redirect_to root_path, alert: 'Failed to create tweet.' }
  #     end
  #   end
  # end

  private
  def set_group
    @group = Group.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def post_params
    params.require(:post).permit(:post)
  end

end
