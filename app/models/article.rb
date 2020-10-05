class Article < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_rich_text :content

  validates :title, presence: true, length: { maximum: 30 }
  validates :target_site, :content, presence: true
end
