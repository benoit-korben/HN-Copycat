class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @posts = Post.all.order(score: :desc).first(30)
  end
  def upvote
    @post = Post.find(params[:id])
    if current_user.upvotes.exists?(post: @post)
      current_user.upvotes.find_by(post: @post).destroy
      @post.update(score: @post.upvotes.count)
    else
      current_user.upvotes.create(post: @post)
      @post.update(score: @post.upvotes.count)
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect to posts_path }
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @rank = params[:index].to_i + 1
  end
end
