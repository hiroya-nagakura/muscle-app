require 'rails_helper'

RSpec.feature 'Bodyweights', type: :feature do
  before do
    @user = create(:user,
                   user_name: 'tester',
                   email: 'test@example.com',
                   password: 'password')
  end
  xscenario '新しい体重記録を作成、編集、削除する' do
    # トップページを開く
    visit root_path

    # ログインページへ
    click_link 'ログイン'

    # ログインする
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    expect(page).to have_text('ログインしました')

    # 体重記録ページへ
    click_link '体重記録'
    find 'h2', text: '体重記録'

    # 新しく体重を記録する
    expect do
      fill_in '日付', with: '002020/09/26'
      fill_in '体重', with: '70.0'
      click_button '記録する'
      find 'p', text: '体重を記録しました'
    end.to change(Bodyweight.all, :count).by(1)

    # 記録が反映されたことを検証する
    bodyweight = Bodyweight.first
    aggregate_failures do
      expect(bodyweight.day).to eq '2020-09-26'
      expect(bodyweight.weight).to eq '70.0'
    end
    expect(current_path).to eq user_bodyweights_path(@user)

    # ーーーーーー記録を編集ーーーーーー
    # 記録の編集
    with_in '.weight-edit-field' do
      fill_in 'bodyweight_weight', with: '80.0'
      click_button '編集する'
    end

    # 編集が反映されたことを検証
    find 'p', text: '編集しました'
    bodyweight.reload
    expect(bodyweight.weight).to eq '80.0'
    expect(current_path).to eq user_bodyweights_path(@user)

    # ーーーーーー記事を削除ーーーーーー
    # 記事を削除し、削除されたことを検証
    expect do
      click_link '×'
      find 'p', text: '削除しました'
    end.to change(Bodyweight.all, :count).by(-1)
  end
end
