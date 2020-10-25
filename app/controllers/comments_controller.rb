class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_target_article

  def create
    @comment = current_user.comments.new(comment_params)
    return @msg = 'コメントを投稿しました' if @comment.save

    redirect_to article_path(@article), alert: 'コメントの投稿に失敗しました'
  end

  def destroy
    @comment = Comment.find(params[:id])
    @msg = 'コメントを削除しました'if @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :article_id)
  end

  def set_target_article
    @article = Article.find(params[:article_id])
  end
end
