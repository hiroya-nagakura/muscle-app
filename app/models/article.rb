class Article < ApplicationRecord
  YOUTUBE_URL = /\A(https\:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)+[\S]{11,}\z/

  belongs_to :user
  belongs_to :target_site
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  has_rich_text :content

  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true
  validates :article_tags, length: {maximum: 5 }
  validates :youtube_url, allow_blank: true, format: { with: YOUTUBE_URL }
end
