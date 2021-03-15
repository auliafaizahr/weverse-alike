class WatchMediasController < ApplicationController
  before_action :set_media
  layout "watch_layout"
  def show
    
  end

  private

  def set_media
    @media = MediaVideo.find(params[:media_id])
  end
end
