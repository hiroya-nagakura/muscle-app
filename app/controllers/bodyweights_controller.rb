class BodyweightsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_user
  before_action :allow_correct_user, only: %i[create update destroy]
  before_action :deny_bodyweights_browsing, only: %i[index]

  def index
    @bodyweight = Bodyweight.new
    standard_date = Time.current
    standard_date = Time.current.ago(params[:date].to_i.weeks) if params[:date]
    # 表示用範囲設定
    @date_range = standard_date.beginning_of_week.to_date..standard_date.end_of_week.to_date # 一週間分
    @dailychart_range = standard_date.all_week # 一週間分
    @weeklychart_range = standard_date.ago(1.month).beginning_of_month..standard_date.end_of_month # 二ヶ月分
    @monthlychart_range = standard_date.all_year # 一年分
    # 一週間より一つ前のレコードの体重の取得（前回比用）
    last_weight_record = @user.bodyweights.order(day: :desc).where('day < ? ', standard_date.beginning_of_week).first
    @last_weight = last_weight_record.weight if last_weight_record
    # 曜日表示用
    @weeks = %w[日 月 火 水 木 金 土]
  end

  def create
    @bodyweight = current_user.bodyweights.build(weight_params)
    return  redirect_to user_bodyweights_path(@user), notice: '体重を記録しました' if @bodyweight.save
    # レンダリングでは諸々の変数を設定しないといけないためリダイレクトに設定
    redirect_to user_bodyweights_path(@user),
                flash: { alert: '記録に失敗しました',
                         error_messages: @bodyweight.errors.full_messages }
  end

  def update
    @bodyweight = Bodyweight.find(params[:id])
    return  redirect_to user_bodyweights_path(@user), notice: '編集しました' if @bodyweight.update(weight_params)
    
    redirect_to user_bodyweights_path(@user),
                flash: { alert: '編集に失敗しました',
                         error_messages: @bodyweight.errors.full_messages }
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

  def allow_correct_user
    redirect_to user_bodyweights_path(@user) unless @user == current_user
  end

  #非公開設定していたら本人以外はトップページへリダイレクト
  def deny_bodyweights_browsing
    unless @user == current_user || @user.bodyweights_is_released
      redirect_to root_path, alert: "#{@user.user_name}さんは体重管理を非公開に設定しています" 
    end
  end
end
