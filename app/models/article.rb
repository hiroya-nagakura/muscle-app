class Article < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  has_rich_text :content

  
  validates :title, :target_site, :body, presence: true
end
