class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[create destroy]

  def create
    respond_to do |format|
      if @post.likes.where(user_id: current_user.id).first_or_create
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  def destroy
    @post.likes.find_by(likeable_id: params[:post_id]).destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end
