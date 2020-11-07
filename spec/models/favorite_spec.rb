require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { create(:user) }
  let(:article) {create(:article)}
  let(:favorite) { create(:favorite) }

  it '有効なファクトリを持つこと' do
    expect { create(:favorite) }.to change(Favorite.all, :count).by(1)
  end

  it 'user, articleがあれば有効であること' do
    favorite = Favorite.new(
      user: user,
      article: article
    )
    expect(favorite).to be_valid
  end

  describe '存在性の検証' do
    it 'userがなければ無効であること' do
      favorite.user = nil
      favorite.valid?
      expect(favorite.errors[:user]).to include('を入力してください')
    end
    it 'articleがなければ無効であること' do
      favorite.article = nil
      favorite.valid?
      expect(favorite.errors[:article]).to include('を入力してください')
    end
  end
end
