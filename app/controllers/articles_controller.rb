class ArticlesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :new]

  def index
    @articles = Article.all.sort_by(&:points).reverse
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to articles_path
    else
      flash.now[:alert] = @article.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :url)
  end

end
