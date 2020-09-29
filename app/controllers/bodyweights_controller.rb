class BodyweightsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_user
  before_action :correct_user, only: %i[create update destroy]

  def index
    @bodyweight = Bodyweight.new
    @bodyweights = Bodyweight.where(user: @user)
    if params[:date]
      start_date= Date.today.ago(params[:date].to_i.weeks)
    else
      start_date = Date.today
    end
    @date_range = start_date.beginning_of_week.to_date..start_date.end_of_week.to_date
    @last_weight = @bodyweights.order(day: :desc).where("day < ? ", start_date.beginning_of_week).first
    @weeks = ["日","月","火","水","木","金","土"]
  end

  def create
    @bodyweight = current_user.bodyweights.build(weight_params)
    if @bodyweight.save
      redirect_to user_bodyweights_path(@user), notice: '体重を記録しました'
    else
      flash.now[:error_messages] = @bodyweight.errors.full_messages
      redirect_to user_bodyweights_path(@user), flash: {
        alert: '記録に失敗しました',
        error_messages: @bodyweight.errors.full_messages}
    end
  end

  def update
  end

  def destroy
  end

  private
  def weight_params
    params.require(:bodyweight).permit(:weight, :day)
  end
  def set_user
    @user = User.find(params[:user_id])
  end

  def correct_user
    redirect_to(user_records_path(@user)) unless (@user == current_user)
  end
end
