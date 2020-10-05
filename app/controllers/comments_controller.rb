class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_target_article

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to article_path(@article), notice: 'コメントを投稿しました。'
    else
      flash.now[:alert] = '投稿に失敗しました。'
      redirect_to article_path(@article)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    redirect_to article_path(@article) if @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :article_id)
  end

  def set_target_article
    @article = Article.find(params[:article_id])
  end
end
