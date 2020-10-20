require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:relationship) { create(:relationship) }

  it '有効なファクトリを持つこと' do
    expect { create(:relationship) }.to change(Relationship.all, :count).by(1)
  end

  it 'ユーザー、フォローがあれば有効であること' do
    relationship = Relationship.new(
      user: user1,
      follow: user2
    )
    expect(relationship).to be_valid
  end

  describe '存在性の検証' do
    it 'ユーザーがいなければ無効であること' do
      relationship.user = nil
      relationship.valid?
      expect(relationship.errors[:user]).to include('を入力してください')
    end

    it 'フォローがいなければ無効であること' do
      relationship.follow = nil
      relationship.valid?
      expect(relationship.errors[:follow]).to include('を入力してください')
    end
  end
end
