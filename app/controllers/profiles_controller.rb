class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:new, :create, :edit]

  def index
    @user = current_user
    
  end

  def new
    @user = User.new
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def create
    binding.pry
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        if current_user.Admin?
          format.html { redirect_to group_path(@group), notice: 'User was successfully updated.' }
        else
          format.html { redirect_to root_path, notice: 'User was successfully updated.' }
        end
      else
        if current_user.Admin?
          format.html { redirect_to group_path(@group), notice: 'User was successfully updated.' }
        else
          format.html { redirect_to root_path, notice: 'User was successfully updated.' }
        end
      end
    end
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
    params.require(:user).permit(:email, :avatar, :name, :username, :type_user, :password)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

end
