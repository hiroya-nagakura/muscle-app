require 'rails_helper'

RSpec.describe TrainingMenu, type: :model do
  let(:training_menu) { create(:training_menu) }
  let(:record) { create(:record) }

  it '有効なファクトリを持つこと' do
    expect(build(:training_menu)).to be_valid
  end
  it 'menu,recordがあれば有効で状態だあること' do
    training_menu = TrainingMenu.new(
      menu: 'ベンチプレス',
      record: record
    )
    expect(training_menu).to be_valid
  end
  describe '存在性の検証' do
    it 'menuがなければ無効な状態であること' do
      training_menu.menu = nil
      training_menu.valid?
      expect(training_menu.errors[:menu]).to include('を入力してください')
    end
    it 'recordがなければ無効な状態であること' do
      training_menu.record = nil
      training_menu.valid?
      expect(training_menu.errors[:record]).to include('を入力してください')
    end
  end

  describe '数値の検証' do
    it 'weightは0より大きければ有効であること' do
      training_menu.weight = 1
      expect(training_menu).to be_valid
    end
    it 'weightは0では無効であること' do
      training_menu.weight = 0
      training_menu.valid?
      expect(training_menu.errors[:weight]).to include('は0より大きい値にしてください')
    end
    it 'weightは負の数では無効であること' do
      training_menu.weight = -30
      training_menu.valid?
      expect(training_menu.errors[:weight]).to include('は0より大きい値にしてください')
    end
    it 'reoは0より大きければ有効であること' do
      training_menu.rep = 1
      expect(training_menu).to be_valid
    end
    it 'repは0では無効であること' do
      training_menu.rep = 0
      training_menu.valid?
      expect(training_menu.errors[:rep]).to include('は0より大きい値にしてください')
    end
    it 'repは負の数では無効であること' do
      training_menu.rep = -3
      training_menu.valid?
      expect(training_menu.errors[:rep]).to include('は0より大きい値にしてください')
    end
    it 'setは0より大きければ有効であること' do
      training_menu.set = 1
      expect(training_menu).to be_valid
    end
    it 'setは0では無効であること' do
      training_menu.set = 0
      training_menu.valid?
      expect(training_menu.errors[:set]).to include('は0より大きい値にしてください')
    end
    it 'setは負の数では無効であること' do
      training_menu.set = -3
      training_menu.valid?
      expect(training_menu.errors[:set]).to include('は0より大きい値にしてください')
    end
  end
end
