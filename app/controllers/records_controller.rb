class RecordsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_user
  before_action :correct_user, only: %i[new create edit update destroy]

  def index
    @records = Record.where(user: @user)
    @last_record = @records.order(start_time: :'DESC').first
  end

  def new
    @record = Record.new
    @traning_menu = @record.traning_menus.build
  end

  def show
    @record = Record.find(params[:id])
  end

  def create
    @record = current_user.records.build(record_parameter)
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
  end

  def update
    @record = Record.find(params[:id])
    if @record.update(record_parameter)
      redirect_to user_records_path(@user), notice: 'トレーニングメニューを編集しました'
    else
      render 'edit'
    end
  end

  private

  def record_parameter
    params.require(:record).permit(:start_time, traning_menus_attributes: [:id, :menu, :weight, :rep, :set, :note, :_destroy])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def correct_user
    redirect_to(user_records_path(@user)) unless (@user == current_user)
  end

end
