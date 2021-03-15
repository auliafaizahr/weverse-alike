class MediasController < ApplicationController
  layout "layouts/home"
  before_action :set_group, only: [:index, :create, :new, :destroy, :edit, :update]


  def index
    @media_categories = @group.media_video_categories
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
  end
end
