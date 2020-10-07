require 'rails_helper'

RSpec.describe TagGroup, type: :model do
  let(:tag_group) { create(:tag_group) }
  let(:tag) { create(:tag) }
  
  it '有効なファクトリを持つこと' do
    expect(build(:tag_group)).to be_valid
  end
  it 'name があれば有効な状態であること' do
    tag_group = TagGroup.new(
      name: 'タググループ'
    )
    expect(tag_group).to be_valid
  end

  describe '存在性の検証' do
    it 'nameがなければ無効な状態であること' do
      tag_group.name = nil
      tag_group.valid?
      expect(tag_group.errors[:name]).to include('を入力してください')
    end
  end

  describe '削除の検証' do
    it 'タググループを削除したら紐づくタグも削除されること' do
      create(:tag, tag_group: tag_group)
      expect { tag_group.destroy } .to change(tag_group.tags, :count).by(-1)
    end
  end
end
