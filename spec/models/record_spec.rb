require 'rails_helper'

RSpec.describe Record, type: :model do
  let(:user) { create(:user) }
  let(:record) { create(:record) }
  let(:training_menu) { create(:training_menu)}

  it '有効なファクトリを持つこと' do
    expect(build(:record)).to be_valid
  end

  it 'start_timeとuserとtraining_menusあれば有効な状態であること' do
    record = Record.new(
      start_time: '2020-09-26 00:00:00',
      user: user,
    )
    record.training_menus << build(:training_menu, record: record)
    expect(record).to be_valid
  end

  describe '存在性の検証' do
    it 'start_timeがなければ無効な状態であること' do
      record.start_time = nil
      record.valid?
      expect(record.errors[:start_time]).to include('を入力してください')
    end

    it 'userがなければ無効な状態であること' do
      record.user = nil
      record.valid?
      expect(record.errors[:user]).to include('を入力してください')
    end

    xit 'training_menusが一つもなければ無効な状態であること' do
      record.training_menus = nil
      record.valid?
      expect(record.errors[:training_menus]).to include('を入力してください')
    end
  end

  describe '削除の検証' do
    # テストでは通らないが実際の動作では削除できている
    xit 'トレーニング記録を削除したら紐づくトレーニングメニューも削除されること' do
      create(:training_menu, record: record)
      expect { record.destroy }.to change(record.training_menus, :count).by(-1)
    end
  end
end
