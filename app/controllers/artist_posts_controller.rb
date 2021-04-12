class ArtistPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group
  before_action :set_artists
  layout "layouts/home"

  def index
    @user = current_user
    if params[:date_filter]
      check_date
      respond_to do |format|
        format.html
        format.js { render layout: false }
      end
    else
      set_posts
    end
  end

  def check_date
    @posts = []
    binding.pry
    if params[:date_filter].empty?
      if params[:user_id]
        set_artist
        @artist.posts.order("created_at DESC").each do |post|
          @posts << post
        end
      else
        @artists.each do |artist|
          artist.posts.order("created_at DESC").each do |post|
            @posts << post
          end
        end
      end
    else
      set_date
      if params[:user_id]
        set_artist
        @artist.posts.where(:created_at => @date_start.beginning_of_day..@date_end.end_of_day).order("created_at DESC").each do |post|
          @posts << post
        end
      else
        @artists.each do |artist|
          artist.posts.where(:created_at => @date_start.beginning_of_day..@date_end.end_of_day).order("created_at DESC").each do |post|
            @posts << post
          end
        end
      end
    end
    @posts = @posts.sort.reverse
  end

  def set_date
    date_params = params[:date_filter].gsub(/\s+/, "").split("-")
    @date_start = Date.strptime(date_params.first, "%m/%d/%Y")
    @date_end = Date.strptime(date_params.last, "%m/%d/%Y")
  end

  def set_artist
    @artist = @artists.find(params[:user_id])
  end

  def check_artist
    
  end

  def artist_and_date
    
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
    binding.pry
    @artists = @group.users.artist
    date_params = params[:date_filter].gsub(/\s+/, "").split("-")
    date_params = params[:date_filter].gsub(/\s+/, "").split("-")
    date_start = Date.strptime(date_params.first, "%m/%d/%Y")
    date_end = Date.strptime(date_params.last, "%m/%d/%Y")
    @posts = []
    if params[:user_id]
      artist = @artists.find(params[:user_id])
      artist.posts.where(:created_at => date_start.beginning_of_day..date_end.end_of_day).order("created_at DESC").each do |post|
        @posts << post
      end
    end
    @artists.each do |artist|
      artist.posts.where(:created_at => date_start.beginning_of_day..date_end.end_of_day).order("created_at DESC").each do |post|
        @posts << post
      end
    end
    @posts = @posts.sort.reverse
  end

  def set_posts
    set_group
    @artists = @group.users.artist
    @posts = []
    @artists.each do |artist|
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

  def set_artists
    @artists = @group.users.artist
  end

end
