class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable, only: [:create]
  before_action :set_group, only: [:create]

  def index
    
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to group_posts_path(@group), notice: 'Comment was successfully created.' }
        format.js
      else
        format.html { redirect_to group_posts_path(@group), alert: 'Failed to create comment.' }
      end
    end
  end

  private
  def set_commentable
    if params[:post_id]
      @commentable = Post.find(params[:post_id])
    elsif params[:media_id]
      @commentable = MediaVideo.find(params[:media_id])
    end
  end

  def comment_params
    user_id = current_user.id
    params.require(:comment).permit(:comment, :user_id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end