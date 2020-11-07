require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  it '有効なファクトリを持つこと' do
    expect(build(:user)).to be_valid
  end

  it 'user_name、email、passwordがあれば有効な状態であること' do
    user = User.new(
      user_name: 'TestUser',
      email: 'test@expample.com',
      password: 'password'
    )
    expect(user).to be_valid
  end

  describe '存在性の検証' do
    it 'user_nameがなければ無効な状態であること' do
      user.user_name = nil
      user.valid?
      expect(user.errors[:user_name]).to include('を入力してください')
    end
    it 'emailがなければ無効な状態であること' do
      user.email = nil
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end
  end

  describe '一意性の検証' do
    it '重複したemailなら無効な状態であること' do
      user.save
      dupulicate_user = build(:user, email: user.email)
      dupulicate_user.valid?
      expect(dupulicate_user.errors[:email]).to include('はすでに存在します')
    end
  end

  describe '文字数の検証' do
    it 'passwordが8文字以上の場合、有効であること' do
      user.password = user.password_confirmation = 'a' * 8
      expect(user).to be_valid
    end
    it 'passwordが7文字以下の場合、無効であること' do
      user.password = user.password_confirmation = 'a' * 7
      user.valid?
      expect(user.errors[:password]).to include('は8文字以上で入力してください')
    end
    it 'user_nameが20文字以下の場合、有効であること' do
      user.user_name = 'a' * 20
      expect(user).to be_valid
    end
    it 'user_nameが21文字以上の場合、無効であること' do
      user.user_name = 'a' * 21
      user.valid?
      expect(user.errors[:user_name]).to include('は20文字以内で入力してください')
    end
    it 'emailが255文字以内の場合有効であること' do
      # @example.comまで合わせて255文字
      user.email = 'a' * 243 + '@example.com'
      expect(user).to be_valid
    end
    it 'emailが256文字以上の場合無効であること' do
      # @example.comまで合わせて256文字
      user.email = 'a' * 244 + '@example.com'
      user.valid?
      expect(user.errors[:email]).to include('は255文字以内で入力してください')
    end
  end

  describe 'フォーマットの検証' do
    it '正しいフォーマットのemailは有効であること' do
      user.email = 'test@example.com'
      expect(user).to be_valid
    end
    it '不正なフォーマットのemailは無効であること' do
      user.email = 'test@exmample,com'
      user.valid?
      expect(user.errors[:email]).to include('は不正な値です')
    end
  end

  describe 'パスワードの検証' do
    it 'パスワードと確認用パスワードが間違っている場合、無効であること' do
      user.password = 'password'
      user.password_confirmation = 'pass'
      user.valid?
      expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
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
      expect { user.destroy }.to change(user1.followers, :count).by(-1)
    end
    it '削除すると紐づくコメントも削除されること' do
      create(:comment, user: user)
      expect { user.destroy }.to change(user.comments, :count).by(-1)
    end
    it '削除すると紐づくトレーニング記録も削除されること' do
      create(:record, user: user)
      expect { user.destroy }.to change(user.records, :count).by(-1)
    end
    it '削除すると紐づく体重記録も削除されること' do
      create(:bodyweight, user: user)
      expect { user.destroy }.to change(user.bodyweights, :count).by(-1)
    end

  end

  describe 'メソッドの検証' do
    it 'いいねしていたらtrueを返すこと' do
      article1 = create(:article)
      article2 = create(:article)
      user = create(:user)
      create(:favorite, user_id: user.id, article_id: article1.id)
      expect(user.already_favorite?(article1)).to be_truthy
      expect(user.already_favorite?(article2)).to be_falsy
    end

    it 'フォローすることができること' do
      expect { user.follow(user1) }.to change(user1.followers, :count).by(1)
    end

    it 'フォローを解除することができること' do
      user.follow(user1)
      expect { user.unfollow(user1) }.to change(user1.followers, :count).by(-1)
    end

    it 'フォローしてたらtrue,フォローしてなかったらfalseを返すこと' do
      user.follow(user1)
      expect(user.following?(user1)).to be_truthy
      expect(user.following?(user2)).to be_falsy
    end

    it 'ゲストユーザーの作成ができる' do
      expect do
        @guest_user = User.guest
      end.to change(User.all, :count).by(1)
      expect(@guest_user.user_name).to eq 'ゲストユーザー'
      expect(@guest_user.email).to eq 'guest@example.com'
    end

    it 'ゲストユーザーがいた場合、ゲストユーザーをfindできる' do
      user = User.create(
        email: 'guest@example.com',
        user_name: 'ゲストユーザー',
        password: 'password'
      )
      guest_user = User.guest
      expect(guest_user.user_name).to eq user.user_name
      expect(guest_user.email).to eq user.email
    end
  end
end
