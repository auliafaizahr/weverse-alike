class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to group_posts_path(@group), notice: 'Comment was successfully created.' }
        format.json { render :index, status: :created, location: @comment }
      else
        format.html { redirect_to group_posts_path(@group), alert: 'Failed to create comment.' }
      end
    end
  end

  private
  def set_post
    binding.pry
    @post = Post.find(params[:post_id])
  end

  def comment_params
    user_id = current_user.id
    params.require(:comment).permit(:comment, :user_id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
