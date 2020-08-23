require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }


  it "名前、メール、パスワードがあり、有効なファクトリを持つこと" do
    expect(build(:user)).to be_valid
  end

  it "ユーザー名、メール、パスワードがあれば有効な状態であること" do
    user = User.new(
      user_name: 'TestUser',
      email: 'test@expample.com',
      password: 'password'
    )
    expect(user).to be_valid
  end

  describe '存在性の検証' do
    it "ユーザー名がなければ無効な状態であること" do
      user.user_name = nil
      user.valid?
      expect(user.errors[:user_name]).to include("を入力してください")
    end

    it "メールアドレスがなければ無効な状態であること" do
      user.email = nil
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "重複したメールアドレスなら無効な状態であること" do
      user.save
      dupulicate_user = build(:user, email: user.email)
      dupulicate_user.valid?
      expect(dupulicate_user.errors[:email]).to include("はすでに存在します")
    end
    # ユーザーのフルネームを文字列として返すこと
    it "returns a user's full name as a string"
  end
end
