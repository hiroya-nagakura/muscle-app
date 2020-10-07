class StaticPagesController < ApplicationController
  def home
    # 人気の記事のIDを上から順に10番目まで配列で取得
    article_rank_ary = Favorite.group(:article_id).order('count(article_id) desc').limit(10).pluck(:article_id)
    # それをもとに記事を取得
    @all_ranks = Article.find(article_rank_ary)
    @new_menu = Article.all.order(updated_at: 'DESC').limit(10)
    tag_rank_ary = ArticleTag.group(:tag_id).order('count(tag_id) desc').limit(5).pluck(:tag_id)
    @top5_tag = Tag.find(tag_rank_ary)
  end
end
