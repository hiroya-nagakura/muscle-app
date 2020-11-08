class RecordsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_user
  before_action :deny_records_browsing, only: %i[index]
  before_action :allow_correct_user, only: %i[new create edit update destroy]
  

  def index
    @records = Record.where(user: @user)
    # 最近のトレーニングメニューの取得
    @last_record = @records.order(start_time: :desc).first
  end

  def new
    @record = Record.new
    @record.training_menus.build
  end

  def show
    @record = Record.find(params[:id])
  end

  def create
    @record = current_user.records.build(record_params)
    return  redirect_to user_records_path(@user), notice: 'トレーニングメニューを記録しました'if @record.save

    flash.now[:alert] = '記録に失敗しました'
    flash.now[:error_messages] = @record.errors.full_messages
    render :new
  end

  def destroy
    @records = Record.find(params[:id])
    @records.destroy
    redirect_to user_records_path(@user), notice: 'トレーニングメニューを削除しました'
  end

  def edit
    @record = Record.find(params[:id])
    # 編集画面でメニューを追加できるように設定
    @record.training_menus.build
  end

  def update
    @record = Record.find(params[:id])
    return  redirect_to user_records_path(@user), notice: 'トレーニングメニューを編集しました' if @record.update(record_params)
    
    flash.now[:alert] = '編集に失敗しました'
    flash.now[:error_messages] = @record.errors.full_messages
    render 'edit'
  end

  private

  def record_params
    params.require(:record).permit(:start_time, :main_target, training_menus_attributes: %i[id menu weight rep set note _destroy])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def allow_correct_user
    redirect_to(user_records_path(@user)) unless @user == current_user
  end

  # 非公開設定していたら本人以外はトップページにリダイレクト
  def deny_records_browsing
    unless @user == current_user || @user.records_is_released
      redirect_to root_path, alert: "#{@user.user_name}さんはトレーニング記録を非公開に設定しています"
    end
  end
end
