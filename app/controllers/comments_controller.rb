class CommentsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :new]

  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments.order(created_at: :desc)
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.article_id = params[:article_id]

    if @comment.save
      redirect_to :back
    else
      flash.now[:alert] = @comment.errors.full_messages.join(', ')
      @article = Article.find(params[:article_id])
      @comments = @article.comments.order(created_at: :desc)
      @comment = Comment.new
      render :index
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
