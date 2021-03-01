class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:index, :create, :new]

  def index
    # binding.pry
    @posts = @group.posts.order(created_at: :desc)

    # @post = @group.posts.build
    @user = current_user
    respond_to do |format|
      format.html
    end
  end

  def new
    @post = @group.posts.build(post_params)
  end

  def create
    binding.pry
    # @post = @group.posts.new(post_params)
    @post = @group.posts.build(post_params)
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to group_posts_path(@group), notice: 'Post was successfully created.' }
        format.json { render :index, status: :created, location: @post }
      else
        format.html { redirect_to group_posts_path(@group), alert: 'Failed to create post.' }
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
