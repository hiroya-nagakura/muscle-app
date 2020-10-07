require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) { create(:tag) }
  let(:tag_group) { create(:tag_group) }

  it '有効なファクトリを持つこと' do
    expect(build(:tag)).to be_valid
  end
  it 'name tag_group があれば有効であること' do
    tag = Tag.new(
      name: 'タグ',
      tag_group: tag_group
    )
    expect(tag).to be_valid
  end
  describe '存在性の検証' do
    it 'nameがなければ無効な状態であること' do
      tag.name = nil
      tag.valid?
      expect(tag.errors[:name]).to include('を入力してください')
    end
    it 'tag_groupがなければ無効な状態であること' do
      tag.tag_group = nil
      tag.valid?
      expect(tag.errors[:tag_group]).to include('を入力してください')
    end
  end
end
