class FrontPagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @title = "You havent join this group"
    @groups = Group.all
  end
end
