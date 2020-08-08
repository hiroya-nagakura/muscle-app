class ArticlesController < ApplicationController
  
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to articles_path, notice: 'メニューを投稿しました'
    else
      flash.now[:alert] = '投稿に失敗しました'
      flash.now[:error_messages] = @article.errors.full_messages
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  private
  def article_params
    params.require(:article).permit(:title, :target_site, :need, :recommended_target, :body, :important_point)
  end
end
