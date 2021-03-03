class ArtistPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group
  before_action :set_posts, only: [:index]

  def index
   @user = current_user
    
  end

  def show
    
      
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
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
end
