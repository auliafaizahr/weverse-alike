class MediasController < ApplicationController
  layout "layouts/home"
  before_action :set_group
  before_action :set_media, only: [:show]
  before_action :set_joined_groups, only: [:index, :show]
  # layout 'watch_layout', only: [:show]

  def index
    @user = current_user
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
    render layout: "watch_layout"
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_media
    @media = MediaVideo.find(params[:id])
  end

  def set_joined_groups
    @joined_groups = Group.where(id: JoinGroup.select(:group_id).where(user_id: @user))
    @other_groups = Group.where.not(id: JoinGroup.select(:group_id).where(user_id: @user))
  end
end
