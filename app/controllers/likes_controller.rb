class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likeable, only: [:create, :destroy]

  def create
    if @post
      respond_to do |format|
        if @post.likes.where(user_id: current_user.id).first_or_create
          format.html { redirect_to root_path }
          format. js { render "likes/create.js" }
        end
      end
    else
      respond_to do |format|
        if @comment.likes.where(user_id: current_user.id).first_or_create
          format.html { redirect_to root_path }
          format.js { render "comment_likes/create.js" }
        end
      end
    end
  end

  def destroy
    if @post
      @post.likes.find_by(likeable_id: params[:post_id]).destroy
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { render "likes/destroy.js" }
      end
    else
      @comment.likes.find_by(likeable_id: params[:comment_id]).destroy
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { render "comment_likes/destroy.js" }
      end
    end
  end

  private
  def set_likeable
    if params[:comment_id]
      @comment = Comment.find(params[:comment_id])
    else
      @post = Post.find(params[:post_id])
    end
  end
end
