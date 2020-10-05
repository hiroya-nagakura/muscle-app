class Bodyweight < ApplicationRecord
  belongs_to :user
  validates :weight, presence: true, numericality: { greater_than: 0 }
  validates :day, presence: true, uniqueness: { scope: :user }

  # グラフ作成用
  def self.day_chart_date(range)
    group_by_day(:day, range: range).average(:weight).compact
  end

  def self.week_chart_date(range)
    group_by_week(:day, range: range).average(:weight).compact
  end

  def self.month_chart_date(range)
    group_by_month(:day, range: range).average(:weight).compact
  end
end
