class BodyweightsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_user
  before_action :correct_user, only: %i[create update destroy]

  def index
    @bodyweight = Bodyweight.new
    allweight = Bodyweight.where(user: @user)
    if params[:date]
      start_date= Date.today.ago(params[:date].to_i.weeks)
    else
      start_date = Date.today
    end
    #チャートでの描写範囲の設定
    @bodyweights = allweight.where("day <= ?", start_date.end_of_week)
    #一週間の取得
    @date_range = start_date.beginning_of_week.to_date..start_date.end_of_week.to_date
    #一週間より一つ前のレコードの取得
    last_weight_record = allweight.order(day: :desc).where("day < ? ", start_date.beginning_of_week).first
    #一つ前のレコードの体重の取得
    if last_weight_record
      @last_weight = last_weight_record.weight
    else
      @last_weight = 0
    end
    #曜日表示用
    @weeks = ["日","月","火","水","木","金","土"]
  end

  def create
    @bodyweight = current_user.bodyweights.build(weight_params)
    if @bodyweight.save
      redirect_to user_bodyweights_path(@user), notice: '体重を記録しました'
    else
      #レンダリングでは諸々の変数を設定しないといけないためリダイレクトに設定
      redirect_to user_bodyweights_path(@user), flash: {
        alert: '記録に失敗しました',
        error_messages: @bodyweight.errors.full_messages}
    end
  end

  def update
    @bodyweight = Bodyweight.find(params[:id])
    if @bodyweight.update(weight_params)
      redirect_to user_bodyweights_path(@user), notice: '編集しました'
    else
      redirect_to user_bodyweights_path(@user), flash: {
        alert: '編集に失敗しました',
        error_messages: @bodyweight.errors.full_messages}
    end
  end

  def destroy
    @bodyweight = Bodyweight.find(params[:id])
    @bodyweight.destroy
    redirect_to user_bodyweights_path(@user), notice: '削除しました'
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
