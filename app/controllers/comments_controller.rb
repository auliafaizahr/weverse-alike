class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.build(comment_params)
  end

  private
  def set_post
    @post = Post.find_by(post_id: post_id)
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
