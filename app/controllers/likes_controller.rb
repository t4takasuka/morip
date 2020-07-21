class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    Like.create(user_id: current_user.id, post_id: params[:post_id])
    redirect_to post_path(post.id)
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    like.destroy
    post = Post.find(params[:post_id])
    redirect_to post_path(post.id)
  end
end
