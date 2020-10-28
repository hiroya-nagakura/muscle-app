require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) { create(:user) }
  let(:article) { create(:article) }
  let(:target_site) { create(:target_site) }

  it '有効なファクトリを持つこと' do
    expect { create(:article) }.to change(Article.all, :count).by(1)
  end

  it 'タイトル、標的部位、記事内容,ユーザーがあれば有効な状態であること' do
    article = Article.new(
      title: 'タイトル',
      content: '記事内容',
      user: user,
      target_site: target_site
    )
    expect(article).to be_valid
  end

  describe '存在性の検証' do
    it 'タイトルがなければ無効な状態であること' do
      article.title = nil
      article.valid?
      expect(article.errors[:title]).to include('を入力してください')
    end

    it '標的部位がなければ無効な状態であること' do
      article.target_site = nil
      article.valid?
      expect(article.errors[:target_site]).to include('を入力してください')
    end

    it '記事内容がなければ無効な状態であること' do
      article.content = nil
      article.valid?
      expect(article.errors[:content]).to include('を入力してください')
    end

    it 'ユーザーがなければ無効な状態であること' do
      article.user = nil
      article.valid?
      expect(article.errors[:user]).to include('を入力してください')
    end
  end

  describe '文字数の検証' do
    it 'タイトルが30文字以内だと有効であること' do
      article.title = 'あ' * 30
      expect(article).to be_valid
    end

    it 'タイトルが31文字以上だと無効であること' do
      article.title = 'あ' * 31
      article.valid?
      expect(article.errors[:title]).to include('は30文字以内で入力してください')
    end
  end

  describe '削除の検証' do
    it '記事を削除したら紐づくいいねも削除されること' do
      create(:favorite, article: article)
      expect { article.destroy }.to change(article.favorites, :count).by(-1)
    end

    it '記事を削除したら紐づくコメントも削除されること' do
      create(:comment, article: article)
      expect { article.destroy }.to change(article.comments, :count).by(-1)
    end
  end

  describe 'フォーマットの検証' do
    it '正しいフォーマットのyoutube_urlは有効であること' do
      article.youtube_url = 'https://www.youtube.com/watch?v=u-wS8jABqQI'
      expect(article).to be_valid
    end

    it '不正なフォーマットのyoutube_urlは無効であること' do
      article.youtube_url = 'https://www.google.com/'
      article.valid?
      expect(article.errors[:youtube_url]).to include('は不正な値です')
    end
  end
end
