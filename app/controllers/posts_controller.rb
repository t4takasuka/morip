class PostsController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :search, :tag]

  def index
    @post = Post.includes([:images]).order(created_at: "DESC")
  end

  def new
    @post = Post.new
    @post.images.new
  end

  def create
    Post.create(post_params)
    flash[:notice] = "新規投稿しました。"
    redirect_to root_path
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
    @tag = Tag.new
    @tags = @post.tags
    @user = User.new
    @image = @user.image
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:alertnow] = "投稿を削除しました。"
    redirect_to root_path
  end

  def search
    @post = Post.search(params[:keyword]).order(created_at: "DESC")
    # flash[:alertnow] = "検索結果はありません。"
  end

  def tag
    @tag_list = Tag.includes([:name])
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.all
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :hashbody, images_attributes: [:src, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
