require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  before do
    user = create(:user,
                  user_name: 'tester',
                  email: 'test@example.com',
                  password: 'password')
    @article = create(:article, user: user)
  end
  scenario 'コメントの作成、編集、削除をする' do
    # トップページを開く
    visit root_path

    # ログインページへ
    click_link 'login'

    # ログインする
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    expect(page).to have_text('ログインしました')

    # 投稿一覧ページへ
    click_link 'メニュー一覧'
    find 'h2', text: 'メニュー一覧'

    # 投稿詳細ページへ
    click_link @article.title

    # コメント作成
    find 'h2', text: @article.title
    expect do
      fill_in 'comment_content', with: 'コメント投稿のテスト'
      click_button 'コメントする'
      find 'p', text: 'コメントを投稿しました'
    end.to change(Comment.all, :count).by(1)

    # コメントが反映されたか検証
    comment = Comment.first
    expect(comment.content).to eq 'コメント投稿のテスト'
    expect(current_path).to eq article_path(@article)
    expect(page).to have_text('コメント投稿のテスト')
    # ーーーーコメントの編集（未実装）ーーーーー

    # ーーーーコメントの削除ーーーー
    expect do
      click_link 'コメントを削除'
      expect(page.accept_confirm).to eq "削除しますか？"
      expect(page).to have_text('コメントを削除しました')
    end.to change(Comment.all, :count).by(-1)
  end
end
