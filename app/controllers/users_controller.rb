class UsersController < ApplicationController

  def index
    @users = User.all.order(created_at: "DESC")
  end

  def show
    @user  = User.find(params[:id])
    @posts = @user.posts.order(created_at: "DESC")
    @counts = @user.posts.count
    @likes = @user.likes.count
  end

  def liked_posts
    @user  = User.find(params[:id])
    @posts = @user.liked_posts
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
  end
end
