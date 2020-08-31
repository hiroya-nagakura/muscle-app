require 'rails_helper'

RSpec.feature "Relationships", type: :feature do
  before do
    @user = create(:user,
                  user_name: 'tester',
                  email: 'test@example.com',
                  password: 'password'
                  )
    @other = create(:user)
  end
  scenario 'フォロー、フォロー解除する' do
    #トップページを開く
    visit root_path

    #ログインページへ
    click_link 'login'

    #ログインする
    fill_in "メールアドレス", with: 'test@example.com'
    fill_in "パスワード", with: "password"
    click_button "ログイン"
    expect(page).to have_text('ログインしました')

    #otherのユーザーページへ
    visit user_path(@other)

    #フォローする
    expect do
      click_button 'フォローする'
    end.to change(Relationship.all, :count).by(1)

    #フォローが反映されたか検証
    expect(page).to have_button 'フォロー中'

    #フォロー解除する
    expect do
      click_button 'フォロー中'
    end.to change(Relationship.all, :count).by(-1)

    #フォローが解除できたか検証
    expect(page).to have_button 'フォローする'
  end
end
