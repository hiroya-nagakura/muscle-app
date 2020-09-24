class RecordsController < ApplicationController
  before_action :set_user

  def index
    @records = Record.all
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
    #redirect_to blogs_path, notice:"削除しました"
  end

  def edit
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
    if @record.update(record_parameter)
      #redirect_to blogs_path, notice: "編集しました"
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

end
