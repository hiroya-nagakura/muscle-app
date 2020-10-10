class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_article, only: %i[show edit update destroy]
  before_action :tag_checkbox, only: %i[new create edit update]
  before_action :correct_user, only: %i[edit update destroy]
  def index
    @articles = @search.result(distinct: true).page(params[:page]).per(4)
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
    @comments = @article.comments
    @comment = Comment.new
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: '投稿が編集されました。'
    else
      flash.now[:alert] = '編集に失敗しました'
      flash.now[:error_messages] = @article.errors.full_messages
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: 'メニューを削除しました'
  end

  private

  def article_params
    params.require(:article).permit(:title, :target_site_id, :important_point, :content, tag_ids: [])
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def tag_checkbox
    @muscles_check = Tag.where(tag_group_id: 1)
    @tools_check = Tag.where(tag_group_id: 2)
    @recommends_check = Tag.where(tag_group_id: 3)
    @others_check = Tag.where(tag_group_id: 4)
  end

  def correct_user
    redirect_to(articles_path) unless @article.user == current_user
  end
end
