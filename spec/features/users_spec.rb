require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  before do
    @user = create(:user,
                   user_name: 'tester',
                   email: 'test@example.com',
                   password: 'password')
  end
  scenario 'ユーザー情報を編集する' do
    # トップページを開く
    visit root_path

    # ログインページへ
    click_link 'login'

    # ログインする
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    expect(page).to have_text('ログインしました')

    # ユーザー詳細ページへ
    click_link "#{@user.user_name}さん"

    # ユーザー編集ページへ
    click_link 'プロフィール編集'

    # プロフィールを編集する
    fill_in 'ユーザー名', with: 'tester2'
    fill_in 'メールアドレス', with: 'test2@example.com'
    fill_in '新しいパスワード', with: 'password2'
    fill_in '新しいパスワード確認用', with: 'password2'
    fill_in '現在のパスワード', with: 'password'
    click_button '変更を保存する'

    # 編集が反映されているか検証する
    @user.reload
    aggregate_failures do
      expect(@user.user_name).to eq 'tester2'
      expect(@user.email).to eq 'test2@example.com'
      expect(@user.valid_password?('password')).to eq(false)
      expect(@user.valid_password?('password2')).to eq(true)
    end
    expect(current_path).to eq root_path
    expect(page).to have_text('アカウント情報を変更しました。')
  end

  scenario 'ゲストユーザーでログインする' do
    # トップページを開く
    visit root_path

    # ログインページへ
    click_link 'login'

    # ゲストログイン機能を使ってログイン
    click_link 'ゲストログイン（閲覧用）'

    # ログインできたか検証
    expect(page).to have_text('ゲストユーザーとしてログインしました。')
  end
end
