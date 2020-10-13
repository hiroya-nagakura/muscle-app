class RecordsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_user
  before_action :unreleased
  before_action :correct_user, only: %i[new create edit update destroy]
  

  def index
    @records = Record.where(user: @user)
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
    if @record.save
      redirect_to user_records_path(@user), notice: 'トレーニングメニューを記録しました'
    else
      flash.now[:alert] = '記録に失敗しました'
      flash.now[:error_messages] = @record.errors.full_messages
      render :new
    end
  end

  def destroy
    @records = Record.find(params[:id])
    @records.destroy
    redirect_to user_records_path(@user), notice: 'トレーニングメニューを削除しました'
  end

  def edit
    @record = Record.find(params[:id])
    @record.training_menus.build
  end

  def update
    @record = Record.find(params[:id])
    if @record.update(record_params)
      redirect_to user_records_path(@user), notice: 'トレーニングメニューを編集しました'
    else
      flash.now[:alert] = '編集に失敗しました'
      flash.now[:error_messages] = @record.errors.full_messages
      render 'edit'
    end
  end

  private

  def record_params
    params.require(:record).permit(:start_time, :main_target, training_menus_attributes: %i[id menu weight rep set note _destroy])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def correct_user
    redirect_to(user_records_path(@user)) unless @user == current_user
  end

  def unreleased
    unless current_user == @user
      unless @user.records_is_released
        redirect_to root_path, flash: { alert: "#{@user.user_name}さんは体重管理を非公開に設定しています" }
      end
    end
  end
end
