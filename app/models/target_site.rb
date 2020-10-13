class TargetSite < ApplicationRecord
  has_many :articles

  validates :muscle_name, presence: true
end
