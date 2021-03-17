class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likeable, only: [:create, :destroy]

  def create
    if @likeable
      respond_to do |format|
        if @likeable.likes.where(user_id: current_user.id).first_or_create
          format.html { redirect_to group_posts_path(@group) }
          format. js { render "likes/create.js" }
        end
      end
    end
  end

  def destroy
    if @post
      @post.likes.find_by(likeable_id: params[:post_id]).destroy
      respond_to do |format|
        format.html { redirect_to group_posts_path(@group) }
        format.js { render "likes/destroy.js" }
      end
    elsif @media
      @media.likes.find_by(likeable_id: params[:media_id]).destroy
      respond_to do |format|
        format.html { redirect_to group_media_path(@group, @media) }
        format.js { render "comment_likes/destroy.js" }
      end
    else
      @comment.likes.find_by(likeable_id: params[:comment_id]).destroy
      respond_to do |format|
        format.html { redirect_to group_posts_path(@group) }
        format.js { render "comment_likes/destroy.js" }
      end
    end
  end

  private
  def set_likeable
    set_group
    if params[:comment_id]
      @comment = Comment.find(params[:comment_id])
    elsif params[:media_id] && params[:comment_id]
      @media = MediaVideo.find(params[:media_id])
    else
      @post = @group.posts.find(params[:post_id])
    end
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
