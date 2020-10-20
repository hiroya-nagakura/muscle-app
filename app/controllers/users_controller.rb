class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @articles = @user.articles
    @followings = @user.followings
    @followers = @user.followers
    @favorite_articles = @user.favorite_articles
  end
end
