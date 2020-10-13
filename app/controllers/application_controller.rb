class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    @search = Article.order(updated_at: 'desc').ransack(params[:q])
  end
end
