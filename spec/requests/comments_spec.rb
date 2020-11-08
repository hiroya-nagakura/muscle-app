require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:user) { create(:user) }
  let(:other) { create(:user) }
  before do
    @article = create(:article)
  end

  describe '#create' do
    context '未ログイン状態のとき' do
      it 'コメントを作成できないこと' do
        comment_params = attributes_for(:comment, article_id: @article.id)
        expect do
          post article_comments_path(@article), params: { comment: comment_params }, xhr: true
        end.to change(Comment.all, :count).by(0)
      end
    end
    context 'ログイン状態のとき' do
      before { sign_in(user) }
      it 'コメントを作成できること' do
        comment_params = attributes_for(:comment, article_id: @article.id)
        expect do
          post article_comments_path(@article), params: { comment: comment_params }, xhr: true
        end.to change(Comment.all, :count).by(1)
      end
      it '失敗時、詳細ページにリダイレクトされること' do
        comment_params = attributes_for(:comment, content: nil, article_id: @article.id)
        post article_comments_path(@article), params: { comment: comment_params }, xhr: true
        expect(response).to redirect_to article_path(@article)
      end
    end
  end

  describe '#destroy' do
    context '未ログイン状態のとき' do
      it 'コメントを削除できないこと' do
        comment = create(:comment, article_id: @article.id)
        expect do
          delete article_comment_path(article_id: @article.id, id: comment.id), xhr: true
        end.to change(Comment.all, :count).by(0)
      end
    end
    context 'ログイン状態のとき' do
      it 'コメントを削除できること' do
        sign_in(user)
        comment = create(:comment, user: user, article_id: @article.id)
        expect do
          delete article_comment_path(article_id: @article.id, id: comment.id), xhr: true
        end.to change(Comment.all, :count).by(-1)
      end
    end
  end
end
