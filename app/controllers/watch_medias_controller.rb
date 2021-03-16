class WatchMediasController < ApplicationController
  before_action :set_media
  before_action :set_group
  layout "watch_layout"

  def show
    @comments = @media.comments
    @user = current_user
  end

  private
  def set_media
    @media = MediaVideo.find(params[:media_id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
