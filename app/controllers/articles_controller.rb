class ArticlesController < ApplicationController
  
  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  private
  def article_params
    params[:article].permit(:title, :target_site, :need, :recommended_target, :body, :important_point)
  end
end
