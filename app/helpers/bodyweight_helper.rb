module BodyweightHelper

  # チャートの最大値を設定するメソッド
  def max_value(user, range)
    max_weight = user.bodyweights.where(day: range).maximum(:weight)
    max_weight.round + 1 if max_weight
  end

  # チャートの最小値を設定するメソッド
  def min_value(user, range)
    min_weight = user.bodyweights.where(day: range).minimum(:weight)
    min_weight.round - 1 if min_weight
  end

  # チャート表示用
  def chart_graph(period, user, range)
    chart_max = max_value(user, range)
    chart_min = min_value(user, range)
    if period == 'day'
      line_chart user.bodyweights.group_by_day(:day, range: range).average(:weight).compact, min: chart_min,
                                                                                             max: chart_max
    elsif period == 'week'
      line_chart user.bodyweights.group_by_week(:day, range: range).average(:weight).compact, min: chart_min,
                                                                                              max: chart_max
    elsif period == 'month'
      line_chart user.bodyweights.group_by_month(:day, range: range).average(:weight).compact, min: chart_min,
                                                                                               max: chart_max
    end
  end

  #範囲内に記録があるか確認するメソッド
  def chart_data?(user, range)
    user.bodyweights.where(day: range).present?
  end
end
