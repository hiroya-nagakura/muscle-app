class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    @search = Article.includes([:article_tags, :tags, :target_site, :user]).order(updated_at: :desc).ransack(params[:q])
  end
end
