class ArtistPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group
  layout "layouts/home"

  def index
    binding.pry
    @user = current_user
    if !params[:date_filter].empty?
      post_filter
      respond_to do |format|
        format.html
        format.js { render layout: false }
      end
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
      artist.posts.where(:created_at => date_start.beginning_of_day..date_end.end_of_day).order("created_at DESC").each do |post|
        @posts << post
      end
    end
    @posts = @posts.sort.reverse
  end

  def set_posts
    set_group
    @artist = @group.users.artist
    @posts = []
    @artist.each do |artist|
      artist.posts.order("created_at DESC").each do |post|
        @posts << post
      end
    end
    @posts = @posts.sort.reverse
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
  end

end
