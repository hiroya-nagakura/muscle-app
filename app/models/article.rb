class Article < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_rich_text :body

  
  validates :title, :target_site, :body, presence: true
end
