class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @articles = @user.articles.includes([:article_tags, :tags, :target_site, :user])
    @followings = @user.followings
    @followers = @user.followers
    @favorite_articles = @user.favorite_articles.includes([:article_tags, :tags, :target_site, :user])
  end
end
