require 'rails_helper'

RSpec.feature 'Articles', type: :feature do
  before do
    create(:user,
           user_name: 'tester',
           email: 'test@example.com',
           password: 'password')
    create(:target_site, muscle_name: '胸')
    create(:target_site, muscle_name: '脚')
  end
  scenario '新しい記事を作成,編集、削除する', js: true do
    # トップページを開く
    visit root_path

    # ログインページへ
    click_link 'login'

    # ログインする
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    expect(page).to have_text('ログインしました')

    # 新規投稿ページへ
    click_link 'メニュー投稿'

    # 新規投稿する
    expect do
      fill_in 'メニュー', with: 'ベンチプレス'
      choose '胸'
      fill_in_rich_text_area 'article_content', with: 'テスト'
      fill_in 'コツや注意点、回数など', with: 'テスト'
      click_button '投稿する'
      sleep 0.5
    end.to change(Article.all, :count).by(1)

    # 投稿が反映されたことを検証する
    article = Article.first
    aggregate_failures do
      expect(article.title).to eq 'ベンチプレス'
      expect(article.target_site.muscle_name).to eq '胸'
      # expect(article.content).to eq 'テスト'
      expect(article.important_point).to eq 'テスト'
    end
    expect(current_path).to eq article_path(article)
    expect(page).to have_text('メニューを投稿しました')

    #------記事の編集-------
    # 編集ページに移動
    click_link '編集'

    # 記事の編集
    fill_in 'メニュー', with: 'スクワット'
    choose '脚'
    fill_in_rich_text_area 'article_content', with: 'テスト２'
    fill_in 'コツや注意点、回数など', with: 'テスト２'
    click_button '編集する'

    # 編集が反映されたか検証
    sleep 0.5
    article.reload
    aggregate_failures do
      expect(article.title).to eq 'スクワット'
      expect(article.target_site.muscle_name).to eq '脚'
      # expect(article.content).to eq 'テスト２'
      expect(article.important_point).to eq 'テスト２'
    end
    expect(current_path).to eq article_path(article)
    expect(page).to have_text('投稿が編集されました')

    #----記事の削除-----
    visit article_path(article)
    # 削除されたか検証
    expect do
      click_link '削除'
      expect(page.accept_confirm).to eq "削除しますか？"
      expect(page).to have_text('メニューを削除しました')
    end.to change(Article.all, :count).by(-1)
  end
end
