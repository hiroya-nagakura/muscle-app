require 'rails_helper'

RSpec.feature 'Favorites', type: :feature do
  before do
    user = create(:user,
                  user_name: 'tester',
                  email: 'test@example.com',
                  password: 'password')
    @article = create(:article, user: user)
  end
  scenario 'いいね、いいね解除ができる', js: true do
    # トップページを開く
    visit root_path

    # ログインページへ
    click_link 'ログイン'

    # ログインする
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    expect(page).to have_text('ログインしました')

    # 投稿一覧ページへ
    click_link 'メニュー一覧'
    find 'h2', text: 'メニュー一覧'

    # 詳細ページでいいねする
    click_link @article.title
    find 'h2', text: @article.title
    expect do
      find('.fa-thumbs-up').click
      find ".fas", text: 'いいね！'
    end.to change(Favorite.all, :count).by(1)

    # いいねが反映されたか検証する
    iine = Favorite.first
    expect(iine.article_id).to eq @article.id
    expect(current_path).to eq article_path(@article)

    # 詳細ページでいいねを解除する
    expect do
      find('.fa-thumbs-up').click
      find ".far", text: 'いいね！'
    end.to change(Favorite.all, :count).by(-1)

    # いいねが解除できたか検証する
  end
end
