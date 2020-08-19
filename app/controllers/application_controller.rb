class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    @search = Article.ransack(params[:q])
    @search_articles = @search.result(distinct: true)
    @search_ary = Article.all.select(:target_site).distinct
  end
end
