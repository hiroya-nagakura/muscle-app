class TrainingMenu < ApplicationRecord
  belongs_to :record
  validates :menu, presence: true
end
