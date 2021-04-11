class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:index, :create, :new, :destroy, :edit, :update]
  before_action :set_post, only: [:destroy, :edit, :update]
  before_action :check_join_group, only: [:index, :create, :new, :destroy, :edit, :update]
  layout "layouts/home"

  def index
    @posts =  Post.where(group_id: @group).order("created_at DESC")
    @user = current_user
    @joined_groups = Group.includes(:join_groups).where(id: JoinGroup.select(:group_id).where(user_id: @user))
    @other_groups = Group.includes(:join_groups).where.not(id: JoinGroup.select(:group_id).where(user_id: @user))
    respond_to do |format|
      if check_join_group.any?
        @username = @user.join_groups.find_by(group_id: @group.id).username
        format.html
      else
        format.html { redirect_to new_group_join_group_path(@group), notice: 'You need to join first.' }
      end
    end
  end

  def edit
    @title = "Edit Post"
    @user = current_user
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        if params[:post_attachments]['avatar']
          params[:post_attachments]['avatar'].each do |a|
            @post_attachment = @post.post_attachments.create!(:avatar => a, :post_id=> @post.id)
          end
        end
        format.html { redirect_to group_posts_path(@group), notice: 'Post was successfully updated.' }
        format.json { render :index, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @post = Post.new
    @post = @group.posts.build(post_params)
    @post_attachment = @post.post_attachments.build
  end

  def create
    # @post = @group.posts.new(post_params)
    @post = @group.posts.build(post_params)
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        if params[:post_attachments]
          params[:post_attachments]['avatar'].each do |a|
            @post_attachment = @post.post_attachments.create!(:avatar => a, :post_id=> @post.id)
          end
        end
        format.html { redirect_to group_posts_path(@group), notice: 'Post was successfully created.' }
        format.json { render :index, status: :created, location: @post }
      else
        format.html { redirect_to group_posts_path(@group), alert: 'Failed to create post.' }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to group_posts_path(@group), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def post_params
    params.require(:post).permit(:post).permit(:post, :user_id, :group_id, post_attachments_attributes: [:id, :post_id, :avatar])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def check_join_group
    set_user
    @user.join_group?(@user, @group)
  end
end
