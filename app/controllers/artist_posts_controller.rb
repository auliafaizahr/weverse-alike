class ArtistPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group
  layout "layouts/home"

  def index
    @user = current_user
    if params[:date_filter]
      post_filter
    else
      set_posts
    end
  end

  def show
  end

  def edit



  end

  def update

  end

  def destroy

  end

  def post_filter
    @artist = @group.users.artist
    date_params = params[:date_filter].gsub(/\s+/, "").split("-")
    date_params = params[:date_filter].gsub(/\s+/, "").split("-")
    date_start = Date.strptime(date_params.first, "%m/%d/%Y")
    date_end = Date.strptime(date_params.last, "%m/%d/%Y")
    @posts = []
    @artist.each do |artist|
      artist.posts.where(:created_at => date_start.beginning_of_day..date_end.end_of_day).each do |post|
        @posts << post
      end
    end
  end

  def set_posts
    set_group
    @artist = @group.users.artist
    @posts = []
    @artist.each do |artist|
      artist.posts.each do |post|
        @posts << post
      end
    end
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
  end

end
