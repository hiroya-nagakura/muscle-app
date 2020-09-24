class Record < ApplicationRecord

  belongs_to :user
  has_many :traning_menus, dependent: :destroy
  accepts_nested_attributes_for :traning_menus, reject_if: :all_blank, allow_destroy: true

  validates :start_time, presence: :true
end
