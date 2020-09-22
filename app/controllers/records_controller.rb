class RecordsController < ApplicationController
  
  def index
    @records = Record.all
  end

  def new
    @records = Record.new
  end

  def show
    @records = Record.find(params[:id])
  end

  def create
    Record.create(record_parameter)
    #redirect_to blogs_path
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

  def blog_parameter
    params.require(:record).permit(:menu, :weight, :rep, :set, :start_time)
  end

end
