class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likeable, only: [:create, :destroy]

  def create
    respond_to do |format|
      if @likeable.likes.where(user_id: current_user.id).first_or_create
        if params[:post_id]
          format.html { redirect_to group_posts_path(@group) }
          format. js { render "likes/create.js" }
        elsif params[:media_id]
          format.html { redirect_to group_media_path(@group, @likeable) }
          format. js { render "likes/create.js" }
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if params[:post_id]
        @likeable.likes.find_by(likeable_id: params[:post_id]).destroy
        format.html { redirect_to group_posts_path(@group) }
        format. js { render "likes/destroy.js" }
      elsif params[:media_id]
        @likeable.likes.find_by(likeable_id: params[:media_id]).destroy
        format.html { redirect_to group_media_path(@group, @likeable) }
        format. js { render "likes/destroy.js" }
      end
    end
  end

  private
  def set_likeable
    set_group
    if params[:post_id]
      @likeable = @group.posts.find(params[:post_id])
    elsif params[:media_id]
      @likeable = @group.media_videos.find(params[:media_id])
    end
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
