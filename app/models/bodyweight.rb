class Bodyweight < ApplicationRecord
  belongs_to :user
  validates :weight, presence: true, numericality: { greater_than: 0 }
  validates :day, presence: true, uniqueness: { scope: :user }
end
