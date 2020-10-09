class Article < ApplicationRecord
  belongs_to :user
  belongs_to :target_site
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  has_rich_text :content

  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true
end
