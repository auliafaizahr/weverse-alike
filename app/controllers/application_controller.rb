class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if resource.Admin?
      admins_path
    elsif resource.Artist?
      @user = resource
      @group = @user.groups.first
      group_posts_path(@group)
    else
      root_path
    end
  end
end
