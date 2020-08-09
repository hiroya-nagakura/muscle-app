class FavoritesController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @favorite = current_user.favorites.create(article_id: params[:article_id])
    @favorite_count = Favorite.where(article_id: params[:article_id]).count
  end

  def destroy
    @article = Article.find(params[:article_id])
    @favorite = Favorite.find_by(user_id: current_user.id, article_id: params[:article_id])
    @favorite.destroy
    @favorite_count = Favorite.where(article_id: params[:article_id]).count
  end

end