class StaticPagesController < ApplicationController
  def home
    #最新のトレーニングレコードを取得
    @last_record = Record.where(user: current_user).order(start_time: :desc).first
    #チャート表示に必要な情報の取得
    @bodyweights = Bodyweight.where(user: current_user)
    @dailychart_range = Date.current.ago(1.week).to_date..Date.current.to_date # 表示データ範囲
    chart_bodyweight = @bodyweights.where(day: @dailychart_range)
    if chart_bodyweight.present? # 最大値、最小値の設定
      @max = chart_bodyweight.maximum(:weight).round + 1
      @min = chart_bodyweight.minimum(:weight).round - 1
    end
    # 人気の記事のIDを上から順に10番目まで配列で取得
    article_rank_ary = Favorite.group(:article_id).order('count(article_id) desc').limit(10).pluck(:article_id)
    # それをもとに記事を取得
    @all_ranks = Article.find(article_rank_ary)
    # 新しい順に記事を10番目まで取得
    @new_menu = Article.all.order(updated_at: 'DESC').limit(10)
    # よく使用されているタグのIDを５番目まで取得
    tag_rank_ary = ArticleTag.group(:tag_id).order('count(tag_id) desc').limit(5).pluck(:tag_id)
    # それをもとにタグを取得
    @top5_tag = Tag.find(tag_rank_ary)
  end
end
