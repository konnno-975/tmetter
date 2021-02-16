class PostsController < ApplicationController
  before_action :authenticate_user!, {only: [:index,:show,:create,:new,:edit,:update]}

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id:params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(content: params[:content],user_id: current_user.id)
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      flash[:notice] = "文字数制限(1~140文字)"
      render("posts/new")
    end 
  end

  def edit
    @post = Post.find_by(id:params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "更新しました"
      redirect_to("/posts/index")
    else
      flash[:notice] = "失敗しました"
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    i = Like.where(post_id: @post.id).count
    
    i.times do
      @like = Like.find_by(post_id: params[:id])
      @like.destroy
    end
    flash[:notice] ="投稿を削除しました"
    redirect_to("/posts/index")
  end
end
