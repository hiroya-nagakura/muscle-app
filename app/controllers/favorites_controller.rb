class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def create
    @favorite = current_user.favorites.create(article_id: params[:article_id])
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, article_id: params[:article_id])
    @favorite.destroy
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end
end
