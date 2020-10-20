require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:user) { create(:user) }
  let(:other) { create(:user) }
  before do
    @article = create(:article)
  end

  describe '#create' do
    context '未ログイン状態のとき' do
      it 'コメントを作成できず、ログインページにリダイレクトされること' do
        comment_params = attributes_for(:comment, article_id: @article.id)
        expect do
          post article_comments_path(@article), params: { comment: comment_params }
        end.to change(Comment.all, :count).by(0)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to '/users/sign_in'
      end
    end
    context 'ログイン状態のとき' do
      it 'コメントを作成でき、コメントした記事にリダイレクトされる' do
        sign_in(user)
        comment_params = attributes_for(:comment, article_id: @article.id)
        expect do
          post article_comments_path(@article), params: { comment: comment_params }
        end.to change(Comment.all, :count).by(1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to article_path(@article)
      end
    end
  end

  describe '#destroy' do
    context '未ログイン状態のとき' do
      it 'コメントを削除できず、ログインページにリダイレクトされること' do
        comment = create(:comment, article_id: @article.id)
        expect do
          delete article_comment_path(article_id: @article.id, id: comment.id)
        end.to change(Comment.all, :count).by(0)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to '/users/sign_in'
      end
    end
    context 'ログイン状態のとき' do
      it 'コメントを削除でき、コメントしていた記事にリダイレクトされること' do
        sign_in(user)
        comment = create(:comment, user: user, article_id: @article.id)
        expect do
          delete article_comment_path(article_id: @article.id, id: comment.id)
        end.to change(Comment.all, :count).by(-1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to redirect_to article_path(@article)
      end
    end
  end
end
