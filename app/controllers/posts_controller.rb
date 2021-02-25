class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:create, :new]

  def index
    @posts = Post.all
    @post = Post.new
    @user = current_user
  end

  def new
    @post = Post.new
  end

  def create
    @post = @group.posts.new(post_params)
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to group_path(@group), notice: 'Post was successfully created.' }
        format.json { render :index, status: :created, location: @post }
      else
        format.html { redirect_to group_path(@group), alert: 'Failed to create post.' }
      end
    end
  end

  private
  def post_params
    params.require(:post).permit(:post)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
