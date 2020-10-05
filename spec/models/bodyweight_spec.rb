require 'rails_helper'

RSpec.describe Bodyweight, type: :model do
  let(:user) { create(:user) }
  let(:bodyweight) { create(:bodyweight) }

  it '有効なファクトリを持つこと' do
    expect(build(:bodyweight)).to be_valid
  end

  it 'weight, day, userがあれば有効な状態であること' do
    bodyweight = Bodyweight.new(
      weight: 70.0,
      day: '2020-09-26',
      user: user
    )
    expect(bodyweight).to be_valid
  end

  describe '存在性の検証' do
    it 'weightがなければ無効な状態であること' do
      bodyweight.weight = nil
      bodyweight.valid?
      expect(bodyweight.errors[:weight]).to include('を入力してください')
    end

    it 'dayがなければ無効な状態であること' do
      bodyweight.day = nil
      bodyweight.valid?
      expect(bodyweight.errors[:day]).to include('を入力してください')
    end

    it 'userがなければ無効な状態であること' do
      bodyweight.user = nil
      bodyweight.valid?
      expect(bodyweight.errors[:user]).to include('を入力してください')
    end
  end

  describe '数値の検証' do
    it 'weightは0より大きければ有効であること' do
      bodyweight.weight = 1
      expect(bodyweight).to be_valid
    end

    it 'weightは0では無効なこと' do
      bodyweight.weight = 0
      bodyweight.valid?
      expect(bodyweight.errors[:weight]).to include('は0より大きい値にしてください')
    end

    it 'weightは負の数では無効なこと' do
      bodyweight.weight = -70
      bodyweight.valid?
      expect(bodyweight.errors[:weight]).to include('は0より大きい値にしてください')
    end
  end

  describe '一意性の検証' do
    it '重複したuserとdayの組み合わせは無効なこと' do
      bodyweight.save
      dupulicate_bodyweight = build(:bodyweight, user: bodyweight.user, day: bodyweight.day)
      dupulicate_bodyweight.valid?
      expect(dupulicate_bodyweight.errors[:day]).to include('はすでに存在します')
    end
  end
end
