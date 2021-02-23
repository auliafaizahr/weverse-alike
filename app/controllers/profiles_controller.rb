class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    
  end

  def new
    @user = current_user
    
  end

  def create
    
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_path, notice: 'User was successfully updated.' }
        format.json { render :index, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :avatar, :name, :username)
  end

end
