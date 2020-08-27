require 'rails_helper'

RSpec.describe "Articles", type: :request do
    let(:user) { create(:user) }
    let(:other) { create(:user) }
  
  describe "#index" do
    it "正常にアクセスできること" do
      get articles_path
      expect(response).to have_http_status(200)
    end
  end

  describe '#new' do
    context '未ログイン状態のとき' do
      it 'ログインページにリダイレクトされること' do
        get new_article_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to '/users/sign_in'
      end
    end
    context 'ログイン状態のとき' do
      it '正常にアクセスできること' do
        sign_in(user)
        get new_article_path
        expect(response).to have_http_status(200)
      end
    end
  end

  describe '#create' do
    context '未ログイン状態のとき' do
      it '記事を作成できず、ログインページにリダイレクトされること' do
        article_params = attributes_for(:article, user: user)
        expect do
          post articles_path, params: { article: article_params }
        end.to change(Article.all, :count).by(0)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to '/users/sign_in'
      end
    end
    context 'ログイン状態のとき' do
      it '記事を作成でき一覧ページにリダイレクトされること' do
        sign_in(user)
        article_params = attributes_for(:article, user: user)
        expect do
          post articles_path, params: { article: article_params }
        end.to change(Article.all, :count).by(1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to articles_path
      end
    end
  end

  describe '#show' do
    it '正常にアクセスできること' do
      article = create(:article, user: user)
      get article_path(article)
      expect(response).to have_http_status(200)
    end
  end

  describe '#edit' do
    context '未ログイン状態の時' do
      it 'ログインページにリダイレクトされること' do
        article = create(:article, user: user)
        get edit_article_path(article)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to '/users/sign_in'
      end
    end
    context 'ログイン状態のとき' do
      it '投稿者だと正常にアクセスできること' do
        article = create(:article, user: user)
        sign_in(user)
        get edit_article_path(article)
        expect(response).to have_http_status(200)
      end
      it '投稿者以外だと一覧ページにリダイレクトされること' do
        article = create(:article, user: user)
        sign_in(other)
        get edit_article_path(article)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to articles_path
      end
    end
  end

  describe '#update' do
    context '未ログイン状態のとき' do
      it 'ログインページにリダイレクトされること' do
        article = create(:article)
        patch article_path(article)
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/users/sign_in'
      end
    end
    context 'ログイン状態のとき' do
      it '投稿者だと記事を更新できること' do
        article = create(:article, user: user)
        sign_in(user)
        article_params = attributes_for(:article, title: 'ベンチプレス')
        patch article_path(article), params: {article: article_params}
        article.reload
        expect(article.title).to eq('ベンチプレス')
      end
      it '投稿者だと詳細ページにリダイレクトされること' do
        article = create(:article, user: user)
        sign_in(user)
        article_params = attributes_for(:article)
        patch article_path(article), params: {article: article_params}
        expect(response).to have_http_status 302
        expect(response).to redirect_to article_path(article)
      end
      it '投稿者以外だと記事を更新できないこと' do
        article = create(:article, user: user)
        sign_in(other)
        article_params = attributes_for(:article, title: 'ベンチプレス')
        patch article_path(article), params: {article: article_params}
        article.reload
        expect(article.title).not_to eq('ベンチプレス')
      end
      it '投稿者以外だと一覧ページにリダイレクトされること' do
        article = create(:article, user: user)
        sign_in(other)
        article_params = attributes_for(:article)
        patch article_path(article), params: {article: article_params}
        expect(response).to have_http_status 302
        expect(response).to redirect_to articles_path
      end
    end
  end

  describe '#destroy' do
    context '未ログイン状態のとき' do
      it 'ログインページにリダイレクトされること' do
        article = create(:article, user: user)
        delete article_path(article)
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/users/sign_in'
      end
    end
    context 'ログイン状態のとき' do
      it '一覧ページにリダイレクトされること' do
        article = create(:article, user: user)
        sign_in(user)
        delete article_path(article)
        expect(response).to have_http_status 302
        expect(response).to redirect_to articles_path
      end
      it '投稿者だと記事を削除できること' do
        article = create(:article, user: user)
        sign_in(user)
        expect do
          delete article_path(article)
        end.to change(Article.all, :count).by (-1)
      end
      it '投稿者以外だと記事を削除できないこと' do
        article = create(:article, user: user)
        sign_in(other)
        expect do
          delete article_path(article)
        end.to change(Article.all, :count).by (0)
      end
    end
  end
end
