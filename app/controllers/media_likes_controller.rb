class MediaLikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likeable, only: [:create, :destroy]

  def create
    if @media
      respond_to do |format|
        if @media.likes.where(user_id: current_user.id).first_or_create
          format.html { redirect_to group_posts_path(@group) }
          format.js { render "comment_likes/create.js" }
        end
      end
    end
  end

  def destroy
    if @media
      @media.likes.find_by(likeable_id: params[:post_id]).destroy
      respond_to do |format|
        format.html { redirect_to group_posts_path(@group) }
        format.js { render "likes/destroy.js" }
      end
    end
  end

  private
  def set_likeable
    set_group
    if params[:media_id]
      @media = MediaVideo.find(params[:media_id])
    end
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
