class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  
  def index
    @posts = Post.all.order(score: :desc).first(30)
  end
end
