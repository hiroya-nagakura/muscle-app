require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  let(:user) { create(:user) }
  let(:other) { create(:user) }
  let(:target_site) { create(:target_site) }

  describe '#index' do
    it '正常にアクセスできること' do
      get articles_path
      expect(response).to have_http_status(200)
    end
  end

  describe '#new' do
    context '未ログイン状態のとき' do
      it 'ログインページにリダイレクトされること' do
        get new_article_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_session_path
      end
    end
    context 'ログイン状態のとき' do
      before {sign_in(user)}
      it '正常にアクセスできること' do
        get new_article_path
        expect(response).to have_http_status(200)
      end
    end
  end

  describe '#create' do
    context '未ログイン状態のとき' do
      it '記事を作成できないこと' do
        article_params = attributes_for(:article, user: user)
        expect do
          post articles_path, params: { article: article_params }
        end.to change(Article.all, :count).by(0)
      end
      it 'ログインページにリダイレクトされること' do
        article_params = attributes_for(:article, user: user)
        post articles_path, params: { article: article_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_session_path
      end
    end
    context 'ログイン状態のとき' do
      before {sign_in(user)}
      it '記事を作成できること' do
        article_params = attributes_for(:article, user: user, target_site_id: target_site.id)
        expect do
          post articles_path, params: { article: article_params }
        end.to change(Article.all, :count).by(1)
      end
      it '作成後、詳細ページにリダイレクトされること' do
        article_params = attributes_for(:article, user: user, target_site_id: target_site.id)
        post articles_path, params: { article: article_params }
        newest_article = Article.last
        expect(response).to have_http_status(302)
        expect(response).to redirect_to article_path(newest_article)
      end
      it '失敗時、新規作成ページがレンダリングされること' do
        article_params = attributes_for(:article, title: nil,user: user, target_site_id: target_site.id)
        post articles_path, params: { article: article_params }
        expect(response).to have_http_status(200)
        expect(response).to render_template :new
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
        expect(response).to redirect_to user_session_path
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
        expect(response).to redirect_to user_session_path
      end
    end
    context '投稿者でログイン状態のとき' do
      before {sign_in(user)
              @article = create(:article, user: user)}
      it '記事を更新できること' do
        article_params = attributes_for(:article, title: 'ベンチプレス')
        patch article_path(@article), params: { article: article_params }
        @article.reload
        expect(@article.title).to eq('ベンチプレス')
      end
      it '詳細ページにリダイレクトされること' do
        article_params = attributes_for(:article)
        patch article_path(@article), params: { article: article_params }
        expect(response).to have_http_status 302
        expect(response).to redirect_to article_path(@article)
      end
      it '失敗時、編集ページにリダイレクトされること' do
        article_params = attributes_for(:article, title: nil)
        patch article_path(@article), params: { article: article_params }
        expect(response).to have_http_status(200)
        expect(response).to render_template :edit
      end
    end
    context '投稿者以外でログイン状態のとき' do
      before {sign_in(other)
              @article = create(:article, user: user)}
      it '投稿者以外だと記事を更新できないこと' do
        article_params = attributes_for(:article, title: 'ベンチプレス')
        patch article_path(@article), params: { article: article_params }
        @article.reload
        expect(@article.title).not_to eq('ベンチプレス')
      end
      it '投稿者以外だと一覧ページにリダイレクトされること' do
        article_params = attributes_for(:article)
        patch article_path(@article), params: { article: article_params }
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
        expect(response).to redirect_to user_session_path
      end
    end
    context '投稿者でログイン状態のとき' do
      before {sign_in(user)
        @article = create(:article, user: user)}
      it '記事を削除できること' do
        expect do
          delete article_path(@article)
        end.to change(Article.all, :count).by(-1)
      end
      it '一覧ページにリダイレクトされること' do
        delete article_path(@article)
        expect(response).to have_http_status 302
        expect(response).to redirect_to articles_path
      end
    end
    context '投稿者以外でログイン状態のとき' do
      before {sign_in(other)
        @article = create(:article, user: user)}
      it '記事を削除できないこと' do
        expect do
          delete article_path(@article)
        end.to change(Article.all, :count).by(0)
      end
      it '一覧ページにリダイレクトされること' do
        delete article_path(@article)
        expect(response).to have_http_status 302
        expect(response).to redirect_to articles_path
      end
    end
  end
  
    describe '#youtube_video_id' do
      it 'youtubeのURLからvideo_idを返すこと' do
        article = create(:article, youtube_url: 'https://www.youtube.com/watch?v=u-wS8jABqQI')
        yt_Regexp = /(https\:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)/
        article.youtube_url.slice!(yt_Regexp)
        expect(article.youtube_url.first(11)).to eq('u-wS8jABqQI')
      end
    end
end
