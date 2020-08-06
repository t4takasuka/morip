class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    respond_to do |format|
      format.html { redirect_to "/posts/#{@comment.post.id}" }
      format.json
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    comment.destroy
    post = Post.find(params[:post_id])
    flash[:alertnow] = "コメントを削除しました"
    redirect_to post_path(post.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
