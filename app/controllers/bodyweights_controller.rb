class BodyweightsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_user
  before_action :correct_user, only: %i[create update destroy]

  def index
    @bodyweight = Bodyweight.new
    @bodyweights = Bodyweight.where(user: @user)
    standard_date = Date.current
    standard_date = Date.current.ago(params[:date].to_i.weeks) if params[:date]
    # 表示用範囲設定
    @date_range = standard_date.beginning_of_week.to_date..standard_date.end_of_week.to_date # 一週間分
    @dailychart_range = standard_date.prev_week(:monday)..standard_date.end_of_week.to_date # 二週間分
    @weeklychart_range = standard_date.ago(1.month).beginning_of_month..standard_date.end_of_month # 二ヶ月分
    @monthlychart_range = standard_date.all_year # 一年分
    # 一週間より一つ前のレコードの体重の取得（前回比用）
    last_weight_record = @bodyweights.order(day: :desc).where('day < ? ', standard_date.beginning_of_week).first
    @last_weight = last_weight_record.weight if last_weight_record
    # 曜日表示用
    @weeks = %w[日 月 火 水 木 金 土]
    # チャートの最大値、最小値の設定
    @dailychart_max = max_value(@dailychart_range)
    @dailychart_min = min_value(@dailychart_range)
    @weeklychart_max = max_value(@weeklychart_range)
    @weeklychart_min = min_value(@weeklychart_range)
    @monthlychart_max = max_value(@monthlychart_range)
    @monthlychart_min = min_value(@monthlychart_range)
  end

  def create
    @bodyweight = current_user.bodyweights.build(weight_params)
    if @bodyweight.save
      redirect_to user_bodyweights_path(@user), notice: '体重を記録しました'
    else
      # レンダリングでは諸々の変数を設定しないといけないためリダイレクトに設定
      redirect_to user_bodyweights_path(@user),
                  flash: { alert: '記録に失敗しました',
                           error_messages: @bodyweight.errors.full_messages }
    end
  end

  def update
    @bodyweight = Bodyweight.find(params[:id])
    if @bodyweight.update(weight_params)
      redirect_to user_bodyweights_path(@user), notice: '編集しました'
    else
      redirect_to user_bodyweights_path(@user),
                  flash: { alert: '編集に失敗しました',
                           error_messages: @bodyweight.errors.full_messages }
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
    redirect_to(user_bodyweights_path(@user)) unless @user == current_user
  end

  def max_value(range)
    max_weight = @bodyweights.where(day: range).maximum(:weight)
    max_weight.round + 1 if max_weight
  end

  def min_value(range)
    min_weight = @bodyweights.where(day: range).minimum(:weight)
    min_weight.round - 1 if min_weight
  end
end
