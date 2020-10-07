class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.follow(@user)
    @msg = "#{@user.user_name}さんをフォローしました。"
  end

  def destroy
    current_user.unfollow(@user)
    @msg = "#{@user.user_name}さんのフォローを解除しました。"
  end

  private

  def set_user
    @user = User.find(params[:follow_id])
  end
end
