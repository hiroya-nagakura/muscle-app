class Bodyweight < ApplicationRecord
  belongs_to :user
  validates :weight, presence: :true, numericality: {greater_than: 0}
  validates :day , presence: :true, uniqueness: {scope: :user}

  #グラフ作成用
  def self.day_chart_date(range)
    self.group_by_day(:day,range: range).average(:weight).compact
  end

  def self.week_chart_date(range)
    self.group_by_week(:day,range: range).average(:weight).compact
  end

  def self.month_chart_date(range)
    self.group_by_month(:day,range: range).average(:weight).compact
  end

  def self.max_weight(range)
    case range
    when 'day'
      self.where("day >= ?", @start_date.end_of_week.ago(14.days)).maximum(:weight)
    when 'week'
      self.where("day >= ?", @start_date.end_of_week.ago(10.weeks)).maximum(:weight)
    when 'month'
      self.where("day >= ?", @start_date.end_of_week.ago(12.months)).maximum(:weight)
    end
  end

  def self.min_weight(range)
    case range
    when day
      self.where("day >= ?", @start_date.end_of_week.ago(14.days)).minimum(:weight)
    when week
      self.where("day >= ?", @start_date.end_of_week.ago(10.weeks)).minimum(:weight)
    when month
      self.where("day >= ?", @start_date.end_of_week.ago(12.months)).minimum(:weight)
    end
  end
end