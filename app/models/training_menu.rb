class TrainingMenu < ApplicationRecord
  belongs_to :record
  validates :menu, presence: true
  validates :weight, :rep, :set, presence: true, numericality: { greater_than: 0 }
end
