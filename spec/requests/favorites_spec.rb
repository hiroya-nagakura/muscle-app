require 'rails_helper'

RSpec.describe 'Favorites', type: :request do
  let(:user) { create(:user) }

  before do
    @article = create(:article)
  end

  describe '#create' do
    context '未ログイン状態のとき' do
      it 'いいねできないこと' do
        expect do
          post article_favorites_path(@article.id), xhr: true
        end.to change(Favorite.all, :count).by(0)
      end
    end
    context 'ログイン状態のとき' do
      it 'いいねできること' do
        sign_in(user)
        expect do
          post article_favorites_path(@article.id), xhr: true
        end.to change(Favorite.all, :count).by(1)
      end
    end
  end

  describe '#destroy' do
    before do
      @favorite = create(:favorite, user: user, article: @article)
    end
    context '未ログイン状態のとき' do
      it 'いいね解除できないこと' do
        expect do
          delete article_favorite_path(article_id: @article.id, id: @article.favorites[0].id), xhr: true
        end.to change(Favorite.all, :count).by(0)
      end
    end
    context 'ログイン状態のとき' do
      it 'いいねを解除できること' do
        sign_in(user)
        expect do
          delete article_favorite_path(article_id: @article.id, id: @article.favorites[0].id), xhr: true
        end.to change(Favorite.all, :count).by(-1)
      end
    end
  end
end
