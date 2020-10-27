class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_article, only: %i[show edit update destroy]
  before_action :tag_checkbox, only: %i[new create edit update]
  before_action :check_correct_user, only: %i[edit update destroy]
  def index
    @articles = @search.result(distinct: true).page(params[:page]).per(12)
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    return redirect_to articles_path, notice: 'メニューを投稿しました' if @article.save
    
    flash.now[:alert] = '投稿に失敗しました'
    flash.now[:error_messages] = @article.errors.full_messages
    render :new
  end

  def show
    @video_id = youtube_video_id if @article.youtube_url
    @comments = @article.comments
    @comment = Comment.new
  end

  def edit; end

  def update
    return redirect_to @article, notice: '投稿が編集されました。' if @article.update(article_params)
    
    flash.now[:alert] = '編集に失敗しました'
    flash.now[:error_messages] = @article.errors.full_messages
    render :edit
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: 'メニューを削除しました'
  end

  private

  def article_params
    params.require(:article).permit(:title, :target_site_id, :important_point, :content, :youtube_url, tag_ids: [])
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def tag_checkbox
    #タグの種類を分けて表示
    @muscles_check = Tag.where(tag_group_id: 1)
    @tools_check = Tag.where(tag_group_id: 2)
    @recommends_check = Tag.where(tag_group_id: 3)
    @others_check = Tag.where(tag_group_id: 4)
  end

  def check_correct_user
    redirect_to(articles_path) unless @article.user == current_user
  end

  def youtube_video_id
    # Youtubeのよく上に出てるURL
    str1 = 'https://www.youtube.com/watch?v='
    # Youtubeの共有用URL
    str2 = 'https://youtu.be/'
    if @article.youtube_url.include?(str1)
      @article.youtube_url.slice!(str1)
      return @article.youtube_url.first(11)
    elsif @article.youtube_url.include?(str2)
      @article.youtube_url.slice!(str2)
      return @article.youtube_url.first(11)
    end
  end
end
