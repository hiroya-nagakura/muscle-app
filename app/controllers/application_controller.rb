class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    @search_header = Article.ransack(params[:q])
  end

end
