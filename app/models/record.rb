class Record < ApplicationRecord
  belongs_to :user
  has_many :training_menus, dependent: :destroy
  accepts_nested_attributes_for :training_menus, reject_if: :all_blank, allow_destroy: true

  validates :start_time, presence: true
  validates :training_menus, presence: true
end
