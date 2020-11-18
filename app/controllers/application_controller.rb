class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    @search = Article.includes([:article_tags, :tags, :target_site, :user]).ransack(params[:q])
  end
end
