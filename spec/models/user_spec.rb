require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }


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
  end


  describe '一意性の検証' do
    it "重複したメールアドレスなら無効な状態であること" do
      user.save
      dupulicate_user = build(:user, email: user.email)
      dupulicate_user.valid?
      expect(dupulicate_user.errors[:email]).to include("はすでに存在します")
    end
  end

  describe '文字数の検証' do
    it 'パスワードが6文字以上の場合、有効であること' do
      user.password = user.password_confirmation = 'a' * 6
      expect(user).to be_valid
    end

    it 'パスワードが6文字未満の場合、無効であること' do
      user.password = user.password_confirmation = 'a' * 5
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it 'ユーザー名が20文字以下の場合、有効であること' do
      user.user_name = 'a' * 20
      expect(user).to be_valid
    end

    it 'パスワードが21文字以上の場合、無効であること' do
      user.user_name = 'a' * 21
      user.valid?
      expect(user.errors[:user_name]).to include("は20文字以内で入力してください")
    end
  end

  describe 'パスワードの検証' do
    it 'パスワードと確認用パスワードが間違っている場合、無効であること' do
      user.password = 'password'
      user.password_confirmation = 'pass'
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
  end

  describe '削除依存性の検証' do
    it '削除すると紐づくメニュー記事も削除されること' do
      create(:article, user: user)
      expect { user.destroy }.to change(user.articles, :count).by(-1)
    end

    it '削除すると紐づくお気に入りも削除されること' do
      create(:favorite, user: user)
      expect { user.destroy }.to change(user.favorites, :count).by(-1)
    end

    it '削除すると紐づくフォローも削除されること' do
      user.follow(user1)
      expect { user.destroy }.to change(user.followings, :count).by(-1)
    end 

    it '削除すると紐づくフォロワーも削除されること' do
      user.follow(user1)
      expect { user.destroy}.to change(user1.followers, :count).by(-1)
    end

    it '削除すると紐づくコメントも削除される' do
      create(:comment, user: user)
      expect { user.destroy }.to change(user.comments, :count).by(-1)
    end
  end
end
