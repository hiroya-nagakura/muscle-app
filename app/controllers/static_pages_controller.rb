class StaticPagesController < ApplicationController
  def home
    #最新のトレーニングレコードを取得
    @last_record = Record.where(user: current_user).order(start_time: :desc).first
    #チャート表示に必要な情報の取得
    @dailychart_range = Time.current.ago(1.week)..Time.current # 表示データ範囲
    # 人気の記事のIDを上から順に10番目まで配列で取得
    article_rank_ary = Favorite.group(:article_id).order('count(article_id) desc').limit(10).pluck(:article_id)
    # それをもとに記事を取得
    @all_ranks = Article.includes([:article_tags, :tags, :target_site, :user]).find(article_rank_ary)
    # 新しい順に記事を10番目まで取得
    @new_menu = Article.all.order(updated_at: :desc).limit(10).includes([:article_tags, :tags, :target_site, :user])
    # よく使用されているタグのIDを５番目まで取得
    tag_rank_ary = ArticleTag.group(:tag_id).order('count(tag_id) desc').limit(5).pluck(:tag_id)
    # それをもとにタグを取得
    @top5_tag = Tag.find(tag_rank_ary)
  end
end
