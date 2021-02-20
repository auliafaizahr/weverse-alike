class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
    @post = Post.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    binding.pry
    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Tweet was successfully created.' }
        format.json { render :index, status: :created, location: @post }
      else
        format.html { redirect_to root_path, alert: 'Failed to create tweet.' }
      end
    end
  end

  private
  def post_params
    params.require(:post).permit(:post)
  end
end
