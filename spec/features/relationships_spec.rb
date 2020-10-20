require 'rails_helper'

RSpec.feature 'Relationships', type: :feature do
  before do
    @user = create(:user,
                   user_name: 'tester',
                   email: 'test@example.com',
                   password: 'password')
    @other = create(:user)
  end
  scenario 'フォロー、フォロー解除する' do
    # トップページを開く
    visit root_path

    # ログインページへ
    click_link 'ログイン'

    # ログインする
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    expect(page).to have_text('ログインしました')

    # otherのユーザーページへ
    visit user_path(@other)
    find '.prof-name', text: @other.user_name

    # フォローする
    expect do
      click_button 'フォローする'
      find 'p', text: "#{@other.user_name}さんをフォローしました。"
    end.to change(Relationship.all, :count).by(1)

    # フォロー解除する
    expect do
      click_button 'フォロー中'
      find 'p', text: "#{@other.user_name}さんのフォローを解除しました。"
    end.to change(Relationship.all, :count).by(-1)
  end
end
