require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:article) { create(:article) }
  let(:comment) { create(:comment) }

  it '有効なファクトリを持つこと' do
    expect(build(:comment)).to be_valid
  end

  it 'ユーザー、記事、コメント内容があれば有効であること' do
    comment = Comment.new(
      user: user,
      article: article,
      content: 'コメント'
    )
    expect(comment).to be_valid
  end

  describe '存在性の検証' do
    it 'ユーザーがいなければ無効な状態であること' do
      comment.user = nil
      comment.valid?
      expect(comment.errors[:user]).to include('を入力してください')
    end

    it '関連する記事がなければ無効な状態であること' do
      comment.article = nil
      comment.valid?
      expect(comment.errors[:article]).to include('を入力してください')
    end

    it 'コメント内容がなければ無効な状態であること' do
      comment.content = nil
      comment.valid?
      expect(comment.errors[:content]).to include('を入力してください')
    end
  end

  describe '文字数の検証' do
    it 'コメント内容が200文字以内だと有効であること' do
      comment.content = 'あ' * 200
      expect(comment).to be_valid
    end

    it 'コメント内容が201文字以上だと無効であること' do
      comment.content = 'あ' * 201
      comment.valid?
      expect(comment.errors[:content]).to include('は200文字以内で入力してください')
    end
  end
end
