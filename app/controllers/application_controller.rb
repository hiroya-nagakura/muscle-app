class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    @search_header = Article.ransack(params[:q])
    @search = Article.ransack(params[:q])
    @search_ary = Article.all.select(:target_site).distinct
  end
end
