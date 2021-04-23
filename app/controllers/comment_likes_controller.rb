class CommentLikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likeable, only: [:create, :destroy]

  def create
    respond_to do |format|
      if @likeable.likes.where(user_id: current_user.id).first_or_create
        if params[:media_id]
          format. js { render "comment_likes/create.js" }
        elsif params[:post_id]
          format. js { render "comment_likes/create.js" }
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @likeable.likes.find_by(likeable_id: @likeable.id).destroy
        if params[:media_id]
          format.html { redirect_to group_media_path(@group, @media) }
          format. js { render "comment_likes/destroy.js" }
        elsif params[:post_id]
          format.html { redirect_to group_posts_path(@group) }
          format. js { render "comment_likes/destroy.js" }
        end
      end
    end
  end
  
  private
  def set_likeable
    set_group
    if params[:media_id]
      @likeable = Comment.find(params[:media_id])
      @media = @likeable.commentable
    elsif params[:post_id]
      @likeable = Comment.find(params[:post_id])
      @post = @likeable.commentable
    end
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
