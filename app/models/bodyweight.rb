class Bodyweight < ApplicationRecord
  belongs_to :user
  validates :weight, :day, presence: :true

  #グラフ作成用
  def self.day_chart_date
    self.group_by_day(:day, last: 14).average(:weight).compact
  end

  def self.week_chart_date
    self.group_by_week(:day, last: 10).average(:weight).compact
  end

  def self.month_chart_date
    self.group_by_month(:day, last: 12).average(:weight).compact
  end

  def method_name
    
  end
end