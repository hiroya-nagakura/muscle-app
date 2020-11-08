class TrainingMenu < ApplicationRecord
  belongs_to :record
  validates :menu, presence: true
  validates :weight, :rep, :set, allow_blank: true, numericality: { greater_than: 0 }
end
