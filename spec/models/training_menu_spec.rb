require 'rails_helper'

RSpec.describe TrainingMenu, type: :model do
  let(:training_menu) { create(:training_menu) }
  let(:record) { create(:record) }

  it "有効なファクトリを持つこと" do
    expect(build(:training_menu)).to be_valid
  end
  it "menu,recordがあれば有効で状態だあること" do
    training_menu = TrainingMenu.new(
      menu: 'ベンチプレス',
      record: record
    )
    expect(training_menu).to be_valid
  end
  describe '存在性の検証' do
    it "menuがなければ無効な状態であること" do
      training_menu.menu = nil
      training_menu.valid?
      expect(training_menu.errors[:menu]).to include("を入力してください")
    end
    it "recordがなければ無効な状態であること" do
      training_menu.record = nil
      training_menu.valid?
      expect(training_menu.errors[:record]).to include("を入力してください")
    end
  end
  
end
