class StaticPagesController < ApplicationController
  def home
    @all_ranks = Article.find(Favorite.group(:article_id).order('count(article_id) desc').limit(10).pluck(:article_id))
    @new_menu = Article.all.order(updated_at: 'DESC').limit(10)
  end
end
