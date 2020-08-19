class ArticlesController < ApplicationController
  
  def index
    @articles = Article.page(params[:page]).per(10)
    @search = Article.ransack(params[:q])
    @search_articles = @search.result(distinct: true).page(params[:page]).per(10)
    if @search_header
      @search_articles = @search_header.result(distinct: true).page(params[:page]).per(10)
    end
    @search_ary = Article.all.select(:target_site).distinct
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
    @comments = @article.comments
    @comment = Comment.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, notice: '投稿が編集されました。'
    else
      flash.now[:alert] = '編集に失敗しました。'
      flash.now[:error_messages] = @article.errors.full_messages
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, notice: 'メニューを削除しました'
  end

  private
  def article_params
    params.require(:article).permit(:title, :target_site, :need, :recommended_target, :body, :important_point, :content)
  end
end
