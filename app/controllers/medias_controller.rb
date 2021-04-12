class MediasController < ApplicationController
  layout "layouts/home"
  before_action :set_group
  before_action :set_media, only: [:show]
  # layout 'watch_layout', only: [:show]

  def index
    @user = current_user
    @joined_groups = Group.includes(:join_groups).where(id: JoinGroup.select(:group_id).where(user_id: @user))
    @other_groups = Group.includes(:join_groups).where.not(id: JoinGroup.select(:group_id).where(user_id: @user))
    
    if params[:category_id]
      @media_category = @group.media_video_categories.find(params[:category_id])
      @medias = @group.media_videos.where(media_video_category_id: params[:category_id])
    else
      @media_categories = @group.media_video_categories
      @medias = @group.media_videos
    end
    
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @medias }
    end
  end

  def show
    @comments = @media.comments
    @user = current_user
    @joined_groups = Group.includes(:join_groups).where(id: JoinGroup.select(:group_id).where(user_id: @user))
    @other_groups = Group.includes(:join_groups).where.not(id: JoinGroup.select(:group_id).where(user_id: @user))
    render layout: "watch_layout"
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_media
    @media = MediaVideo.find(params[:id])
  end
end
